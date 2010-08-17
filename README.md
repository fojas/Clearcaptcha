Clearcaptcha - minimal user impact captcha
==========================================

Description
-----------
A simple way of protecting forms without annoying users.  Based on Jake Munson's CFFormProtect (http://cfformprotect.riaforge.org).  Feature list borrowed from CFFormProtect

Examples
--------
Adding Clearcaptcha to a view in Rails is easy.  Just use the clearcaptcha_tags view helper method.

     # Add clearcaptcha to a page
     <%= clearcaptcha_tags -%>

Then to verify it in a controller, just use the verify_clearcaptcha method.

     # Check clearcaptcha in a controller
     if verify_clearcaptcha(params)
     	# do stuff because captcha passed
     else
     	# handle captcha failure
     end

Features
--------
**1. Mouse movement**: Did the user move their mouse? If not, it might be a spammer. This test is not very strong because lots of people, including the blind, don't use a mouse when filling out forms. Thus I give this test a low point level by default.

**2. Keyboard used**: Did the user type on their keyboard? This is a fairly strong test, because almost everybody will need to use their keyboard when filling out a form (unless they have one of those form filler browser plugins)

**3. Timed form submission**: How long did it take to fill out the form? A spam bot will usually fail this test because it's automated. Also, sometimes spam bot software will have cached form contents, so the form will look like it took days to fill out. This test checks for an upper and lower time limit, and these values can be easily changed to suit your needs.

**4. Hidden form field**: Most spam bots just fill out all form fields and submit them. This test uses a form field that is hidden by CSS, and tests to make sure that field is empty. If a blind person's screen reader sees this hidden field, there is a field label telling them not to fill it out.

**5. Too many URLs**: Many spammers like to submit a ton of URLs in their posts, so you can configure Clearcaptcha to count how many URLs are in the form contents, and raise a flag if the number is above a configured limit.