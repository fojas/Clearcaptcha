
require 'digest/md5'

module Clearcaptcha
  module ClientHelper
    def clearcaptcha_tags(options = {})
      html = ""
      
      Clearcaptcha::config[:tests].each do |key,val|
        if val["points"] > 0
          html << (self.send(key) rescue '') 
        end
      end
      
      return html
    end
    
    
    private 
    
    def script_include
      return '' if @script_inline
      @script_inline = ''
      if Clearcaptcha.config[:js_type] == "inline"
        @script_inline << %{<script type="text/javascript" >}
        @script_inline << File.open(File.join(File.dirname(__FILE__), '../../public/javascripts/clearcaptcha.js')).read
        @script_inline << %{</script>}    
      else
        @script_inline << javascript_include_tag( "clearcaptcha/clearcaptcha.js") 
      end
      @script_inline   
    end
    
    def mousemove
      return '' if @mmhtml
      @mmhtml = script_include
      @mmhtml << hidden_field_tag("inv_mm1234567891", 0, {:class => "inv_mm"})
      @mmhtml
    end
    
    def keyboardused
      return '' if @kuhtml
      @kuhtml = script_include
      @kuhtml << hidden_field_tag("inv_ku1234567892", 0, {:class => "inv_ku"})
      @kuhtml
    end
    
    def negativetest
      return '' if @nghtml
      @nghtml = '<span '+Clearcaptcha.config[:hide_style]+' >Leave this field empty <input  type="text" name="inv_ng1234567893" value="" /></span>'
      @nghtml
    end
    
    def timedtest
      return '' if @timedhtml
      time_stamp = Time.at(Time.new.to_i)
      time_int = "%d" % time_stamp.to_i
      max_secs = "%d" % (Clearcaptcha.config[:tests]['timedtest']['max_secs'] || 3600)
      min_secs = "%d" % (Clearcaptcha.config[:tests]['timedtest']['min_secs'] || 0)
      hash_secret = Clearcaptcha.config[:hash_secret] || ""
      
      hashed_stamp1 = Digest::MD5.hexdigest(time_stamp.to_s+max_secs+hash_secret)
      hashed_stamp2 = Digest::MD5.hexdigest(time_stamp.to_s+min_secs+hash_secret)
      @timedhtml = ''
      @timedhtml << hidden_field_tag("inv_ts1234567894", time_int)
      @timedhtml << hidden_field_tag("inv_t1h1234567894", hashed_stamp1)
      @timedhtml << hidden_field_tag("inv_t2h1234567894", hashed_stamp2)
      @timedhtml << hidden_field_tag("inv_tms1234567894", max_secs+"-"+min_secs)
      @timedhtml 
    end
  end
end
