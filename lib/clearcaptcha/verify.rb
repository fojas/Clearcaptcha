module Clearcaptcha
  module Verify
    def verify_clearcaptcha(params)
      
      @options = Clearcaptcha::config
      return true if (SKIP_VERIFY_ENV.include? ENV['RAILS_ENV'] ) or @options[:disabled] == true
      @score = @options[:max_points]
      @params = params
      @options[:tests].each do |key,val|
        @score = @score - self.send(key+'_verify')
      end
      return (@score >= 0)

      rescue Exception => e
        raise ClearcaptchaError, e.message, e.backtrace

    end

    private

    def mousemove_verify
      @params['inv_mm1234567891'].to_i > 0 ? 0 : @options[:tests]['mousemove']['points'].to_i
    end

    def keyboardused_verify
      @params['inv_ku1234567892'].to_i > 0 ? 0 : @options[:tests]['mousemove']['points'].to_i
    end

    def negativetest_verify
      !@params['inv_ng1234567893'].nil? && @params['inv_ng1234567893'].blank? ? 0 : @options[:tests]['negativetest']['points'].to_i
    end

    def spamstring_verify
      @params.to_a.flatten.join(' ') =~ Regexp.new( @options[:tests]['spamstring']['teststring']) ? @options[:tests]['spamstring']['points'].to_i: 0
    end

    def urlcount_verify
      @params.to_a.flatten.join(' ').scan('http://').size > @options[:tests]['urlcount']['max'].to_i ? @options[:tests]['urlcount']['points'].to_i: 0
    end
    
    def timedtest_verify
      
      time_int = @params['inv_ts1234567894']
      time_stamp = Time.at(time_int.to_i)
      max_min = @params['inv_tms1234567894']
      max_secs = max_min.split("-")[0] 
      min_secs = max_min.split("-")[1]
      hash_secret = Clearcaptcha.config[:hash_secret] || ""
      
      hashed_stamp1 = Digest::MD5.hexdigest(time_stamp.to_s+max_secs+hash_secret)
      hashed_stamp2 = Digest::MD5.hexdigest(time_stamp.to_s+min_secs+hash_secret)
      
      fail_score = Clearcaptcha.config[:tests]['timedtest']['points']
      
      if hashed_stamp1 != @params["inv_t1h1234567894"] || hashed_stamp2 != @params["inv_t2h1234567894"]
        # timestamp or hash was messed with
        return fail_score
      end
      
      time_diff = (Time.new - time_stamp)
      
      if time_diff > max_secs.to_i || time_diff < min_secs.to_i
        # time outside of acceptable boundaries
        return fail_score
      end
      
      # passed
      return 0
      
    rescue
      return 0
    end
    
  end
end
