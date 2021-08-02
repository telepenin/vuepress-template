---
title: 'Imunify360: Webshield'
meta:
  - name: description
    content: Discover Imunify360 Webshield and its variety of features for ultimate server protection. This page goes over key Webshield components.
---

# Imunify360: Webshield

[[toc]]

:::warning Warning
When the interface IP address is added to or deleted from the system, the restart of the webshield is required for the latter to recognize the new IP.
:::

<div class="notranslate">

```
service imunify360-webshield restart
```
</div>

#### Setting the WebShield "Server" header

Sometimes it's desired to change the WebShield "Server" header to something that suits certain requirements.

To do so, locate the <span class="notranslate">`more_set_headers`</span> directive in the <span class="notrabslate">`/etc/imunify360-webshield/webshield.conf`</span> file.

By default, the directive contains the <span class="notranslate">`"Server: imunify360-webshield/1.8";`</span> value. You can set string after the colon to whatever suits your needs.


## Captcha

The CAPTCHA is a feature intended to distinguish human from machine input and protect websites from the spam and different types of automated abuse. Imunify360 uses [reCAPTCHA](https://www.google.com/recaptcha/intro/invisible.html) service.

:::warning Warning
Please note that the WebShield Captcha is not compatible with aggressive CDN caching modes, like Cloudflare 'cache everything' with 'Edge Cache TTL'. If the Сaptcha page is cached by CDN, a visitor will see the Captcha from CDN cache disregarding it has been passed or not. In order to fix that, either disable the aggressive CDN caching or the Captcha functionality in the Imunify360.
:::

There are two layers in CAPTCHA behavior:

1. If a user of a website is added to the <span class="notranslate">Grey List</span> (the access is blocked), then the CAPTCHA allows him to unblock himself. When he tries to get to the website he is redirected to the Captcha Server by ipset, where he can see the protection page asking to confirm that he is not a robot by ticking a checkbox.

![](/images/captcha.jpg)

::: tip Note
The IP address on the screenshot above is given as an example.
:::

If successful, a user is redirected to the website, which means that the access is unblocked and the IP address of this user is removed from the <span class="notranslate">Grey List</span>.

It is also possible to enable the invisible reCAPTCHA via the Imunify360 [<span class="notranslate">Settings</span> page](/dashboard/#settings). With the invisible reCAPTCHA enabled, a human user is not required to go through human confirmation - the process will pass under the hood and a user will be redirected to the website. In case if invisible reCAPTCHA failed to detect if a user is a human or not, then visible reCAPTCHA appears.

2. The CAPTCHA is always on guard of the websites and checks the activity of each IP. With the help of reCAPTCHA it blocks bots and protects websites from spam and abuse. To learn more about reCAPTCHA follow the [link](https://www.google.com/recaptcha/intro/).

The reCaptcha supports localization. Depending on user’s browser settings, reCaptcha will use the browser default language and allow to change it:

![](/images/local.jpg)

### Captcha page customization

To modify footer, header or body of the CAPTCHA use the templates in <span class="notranslate">`/usr/share/imunify360-webshield/captcha/templates/`</span>.

There are three files:

* <span class="notranslate">`head.tpl`</span> – this file goes inside <span class="notranslate">`<head></head>`</span> tags. So you can add JavaScript, CSS styles, etc.

* <span class="notranslate">`body.tpl`</span> – the main template file, modify it as you wish. CAPTCHA goes above all the layers.

* <span class="notranslate">`static`</span> – here you can place images, CSS, JavaScript, etc. and access these files as <span class="notranslate">`/static/<filename>`</span>.

To find information on supported browsers follow this link [https://support.google.com/recaptcha/answer/6223828](https://support.google.com/recaptcha/answer/6223828).

### Update Captcha localizations

A user can change the text of captcha messages for the supported languages. Note that adding custom language is not supported.

To change the text of the Imunify360 Captcha and update the localizations text, please do the following:

1. Locate appropriate Captcha localization files by running:

    <div class="notranslate">

   ```
   ls /usr/share/imunify360-webshield/captcha/translations/locale/{lang}/LC_MESSAGES/messages.po
   ```

   </div>

   For example for Polish language the catalog looks like this: 
   
    <div class="notranslate">

   ```
   /usr/share/imunify360-webshield/captcha/translations/locale/pl/LC_MESSAGES/messages.po
   ```

   </div>

2. Update Captcha localization files by editing <span class="notranslate">`msgstr "my customization or translation"`</span> for appropriate <span class="notranslate">`msgid “original plain english text"`</span>.

   Where <span class="notranslate">`msgstr`</span> contains text that is shown to user and <span class="notranslate">`msgid`</span> contains Captcha original English text.

   For example:

    <div class="notranslate">

   ``` HTML
   #: templates/index.html:154
   msgid ""
   "We have noticed an unusual activity from your <b>IP {client_ip}</b> and "
   "blocked access to this website."
   msgstr ""
   "Zauważyliśmy nietypową aktywność związaną z twoim adresem <b>IP "
   "{client_ip}</b> i zablokowaliśmy dostęp do tej strony internetowej"
   ```

   </div>

3. To add Polish translation edit text in the <span class="notranslate">`msgstr`</span> field. To change the text for a default English translation, edit text in the <span class="notranslate">`msgid`</span> field.
4. Save files.
5. When translation in <span class="notranslate">`messages.po`</span> files is finished, restart <span class="notranslate">imunify360-webshield</span> service:

<div class="notranslate">

```
service imunify360-webshield restart
```

</div>

6. Block yourself (remove your IP from <span class="notranslate">Imunify360 White List</span> and try to log in to the server via ssh with wrong password until it blocks you). Then go to website and log in. Captcha should appear. Set Polish language and assert that new text is displayed.

### Changing the default keys to Google reCAPTCHA keys

If a server owner has his own Google reCAPTCHA keys (both private and public), he may use them instead of the default CloudLinux keys.

To set Google reCAPTCHA keys, place your keys into the <span class="notranslate">`/etc/imunify360-webshield/webshield-http.conf.d/captchakeys.conf`</span> file as shown in the example below:

<div class="notranslate">

```
captcha_site_key <YOUR_SITE_KEY>;
captcha_secret_key <YOUR_SECRET_KEY>;
```
</div>

Then reload WebShield.

## Configuring reCAPTCHA keys

See [how to setup invisible CAPTCHA](/dashboard/#invisible-captcha).

#### Why do you need to specify the Google reCAPTCHA keys in the Imunify360 product

Imunify360 admin should specify reCAPTCHA keys for the server since we’re planning to completely remove embedded reCAPTCHA keys in the future versions.

In this article, you can find a step by step guide on how to set up a custom site and secret keys for your Imunify360 server.

### How to specify the keys for the Imunify360 CAPTCHA

Public and secret reCAPTCHA keys are required for integration between Imunify360 and Google reCAPTCHA service. 

The site key will be publicly available and shown on pages along with reCAPTCHA widget or Invisible CAPTCHA, whereas the secret key will be stored for intercommunication between the backend of Imunify360 and Google service.

:::tip Note: Due to the captcha rate limit we recommend using different reCAPTCHA keys for each server.
[Google’s quotation](https://developers.google.com/recaptcha/docs/faq#are-there-any-qps-or-daily-limits-on-my-use-of-recaptcha):
If you wish to make more than 1k calls per second or 1m calls per month, you must use reCAPTCHA Enterprise or fill out this form and wait for an exception approval.
:::

### Steps to configure

1. Open [https://www.google.com/recaptcha/admin/create](https://www.google.com/recaptcha/admin/create)
2. Fill in required values
   * Set any value as a label, e.g. <span class="notranslate">_my servers cluster #1_</span>
   * Select _reCAPTCHA v2_
   * Select <span class="notranslate">_Invisible reCAPTCHA badge_</span>
   * Add any dummy domain, e.g. <span class="notranslate">_example.org_</span>
   :::tip Note
   You don’t need to put all your domains here
   :::

   ![](/images/reCaptchaRegister.png)

3. Accept terms and proceed
4. Notice keys

   ![](/images/reCaptchaNoticeKeys.png)

5. You need to put these keys on the Imunify360 settings page

   ![](/images/reCaptchaImunifyKeys.png)

   or use the following CLI commands:

   <div class="notranslate">

   ```
   # imunify360-agent config update '{"WEBSHIELD": {"captcha_site_key": "6Ldu4XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXCN6fJ"}}'

   # imunify360-agent config update '{"WEBSHIELD": {"captcha_secret_key": "6Ldu4XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXQqUuk"}}'
   ```
   </div>

6. The final step is to allow Google to process requests from any of your domains

   * Open the <span class="notranslate">_Settings_</span> page

      ![](/images/reCaptchaVerify.png)

   * And disable the <span class="notranslate">_Verify the origin of reCAPTCHA solutions_</span>

      ![](/images/reCaptchaVerifyDisable.png)

That’s it.

### Verification

In order to make sure that you’ve done everything correctly you need to do the following:

1. Make sure that your IP is not whitelisted (using the CLI):

   <div class="notranslate">

   ```
   # imunify360-agent whitelist ip list
   IP          TTL    COUNTRY  IMPORTED_FROM  COMMENT
   1.2.3.4     10256  None     None           Whitelisted for 3 hours due to successful panel login

   # imunify360-agent whitelist ip delete 1.2.3.4
   OK

   # imunify360-agent whitelist ip list
   IP          TTL    COUNTRY  IMPORTED_FROM  COMMENT
   ```
   </div>

2. Make sure your target domain is not [whitelisted](/terminology/):

   <div class="notranslate">

   ```
   # imunify360-agent whitelist domain list
   example.com
   ```
   
   ```
   # imunify360-agent whitelist domain delete example.com
   OK
   ```
   
   </div>

3. Send at least two WAF test requests to any domain on the server

   <div class="notranslate">

   ```
   # curl -v http://example.org/?i360test=88ff0adf94a190b9d1311c8b50fe2891c85af732
   ```
   </div>

4. Open your test domain in the browser and let it pass the captcha challenge
5. Check the list of whitelisted IPs again

   <div class="notranslate">

   ```
   # imunify360-agent whitelist ip list
   IP          TTL    COUNTRY  IMPORTED_FROM  COMMENT
   1.2.3.4     86377  None     None           IP auto-whitelisted with expiration date: 2020-05-28 15:29:34

   ```
   </div>

If you see that your IP is whitelisted then integration between Imunify360 and reCAPTCHA service was **done properly**.

You can watch how invisible reCAPTCHA works at [https://www.youtube.com/watch?v=GQXmAj5hyDo](https://www.youtube.com/watch?v=GQXmAj5hyDo).

:::tip Note
It is also possible to test Captcha by the server IP. Find more information [here](/faq_and_known_issues/#_20-how-to-check-that-captcha-works)
:::

## CDN Support
	
Imunify360 correctly graylists and blocks IPs behind Cloudflare and other CDNs (see [here](/webshield/#supported-cdn-providers) for the full list).
	
Imunify360 passes all requests from CDN through <span class="notranslate">WebShield</span>, and uses <span class="notranslate">CF-Connecting-IP</span> and <span class="notranslate">X-Forwarded-For</span> headers to identify real IPs.
	
To enable it now, run the command:
	
<div class="notranslate">

```sh
imunify360-agent config update '{"WEBSHIELD": {"known_proxies_support": true}}'
```

</div>

::: tip Note
If you are using cPanel/EasyApache3, Imunify360 will not automatically deploy _mod_remoteip_, and log files will show local server IP for visitors coming from CDN. EasyApache 3 is EOL since December 2018, and we don't plan to add automated _mod_remoteip_ setup and configuration for it.
:::
:::tip Note
For cPanel/EasyApache 4, Plesk, DirectAdmin and LiteSpeed _mod_remoteip_ will be automatically installed and configured.
:::
	
#### Supported CDN providers:

* Cloudflare
* MaxCDN
* StackPath CDN
* KeyCDN
* Dartspeed.com
* QUIC.cloud CDN
* NuCDN
* Google CDN
* CloudFront CDN
* GoCache CDN
* Opera
* QUANTIL
* QUIC.cloud CDN
* BunnyCDN
* Sucuri WAF
* Ezoic

#### How to trust all IPs that are specified by Ezoic CDN

The “trust_ezoic” option for WebShield allows you to trust all IPs that are specified by Ezoic CDN as their own servers. By default the option is switched off, but it can be switched on in a straightforward way. Be aware when using this option, at this moment the list of Ezoic CDN servers is quite big and includes ranges that can be controlled by someone else in Amazon EC2.

To enable it, open the `/etc/imunify360-webshield/virtserver.conf` file, find the directive set

<div class="notranslate">

```
$trust_ezoic 0;
```
</div>

replace `0` with `1`, save the file and restart WebShield, using the following command: 

<div class="notranslate">

```
# service imunify360-webshield restart
```
</div>


### SplashScreen for Chinese customers

Imunify360 Captcha isn't available in some countries due to certain restrictions, for example, in China. To alleviate this, Chinese customers can use Imunify360 SplashScreen as Captcha.

To enable SplashScreen, open the file <span class="notranslate">`/etc/imunify360-webshield/wscheck.conf`</span>, find the following line: 

<div class="notranslate">

```
wscheck_splashscreen_as_captcha off;
```
</div>

Change <span class="notranslate">`off`</span> to <span class="notranslate">`on`</span>:

<div class="notranslate">

```
wscheck_splashscreen_as_captcha on;
```
</div>

Save the file and run the following command:

**For Ubuntu:**

<div class="notranslate">

```
service imunify360-websheld reload
```
</div>

**For CentOS:**

<div class="notranslate">

```
systemctl reload imunify360-webshield
```
</div>


The graylisted visitors will see such screen for 5 seconds before redirecting to their initial destination.

![](/images/splash_as_captcha.png)

:::warning Note
You can find WebShield and Captcha related logs in the <span class="notranslate">`/var/log/imunify360-webshield/`</span> file.
:::

### How to block attacks from a particular country in WebShield

Country blocking is available in both [Admin UI](/dashboard/#black-list) and [CLI](/command_line_interface/#blacklist)



## Anti-bot protection


Starting from version 5.6, Imunify360 distinguishes bots from real visitors using the JavaScript challenge <span class="notranslate">"Splash Screen</span>." Most bots don’t solve the challenge, and their requests will not reach web applications such as WordPress, Drupal, and others. This can save the server’s resources and protects websites from scanners, automated attacks, and web-spammers.

Only bad actors will be redirected to the Imunify360 <span class="notranslate">Splash Screen</span> challenge page. Legitimate visitors get original content without any verification page nor any delay. The users forced to the <span class="notranslate">Splash Screen</span> will not see the challenge or CAPTCHA and be redirected to the page with the original content. Cookies and JavaScript support are required in a browser to successfully pass the challenge of <span class="notranslate">Anti-bot protection</span>.

The “Anti-bot protection” feature will not block legitimate bots (e.g., Google crawler).

You can enable <span class="notranslate">Anti-bot protection</span>, in the UI. Go to the <span class="notranslate">General</span> tab -> <span class="notranslate">Settings</span> and check the <span class="notranslate">Anti-bot protection</span> checkbox. You can find the details [here](/dashboard/#anti-bot-protection).

Or via CLI. To do so, run the following command:

<div class="notranslate">

```
# imunify360-agent config update '{"WEBSHIELD": {"splash_screen": true}}'
```
</div>

## How to write custom code on WebShield

Starting from Imunify360 v.5.7, users can change WebShield configuration by creating custom configuration files, which will be included in general config once WebShield will start.

To enable it, open the `/etc/imunify360-webshield/virtserver.conf` file, find the directive `set $trust_ezoic 0;`.

Replace `0` with `1`, save the file and restart WebShield by running the following command:

<div class="notranslate">

```
# service imunify360-webshield restart
```
</div>

Example of the code on Lua:

<div class="notranslate">

```lua
header_filter_by_lua_block {
   local args = ngx.var.query_string
   if args == nil then
       if ngx.req.get_method() == 'GET' then ngx.header.set_cookie = nil
end
}
```
</div>

### How to disable a specific request method

Following is an example of customizing WebShield by disabling a specific request method.

In the example the <span class="notranslate">`OPTIONS`</span> method is disabled.

1. Place the following code into the <span class="notranslate">`/etc/imunify360-webshield/webshield-captcha.conf.d/no-options.conf`</span>
   <div class="notranslate">

   ```lua
   if ($request_method = OPTIONS) {
      return 403;
   }
   ```
   </div>
2. Restart WebShield by running the following command:
   <div class="notranslate">

   ```shell
   service imunify360-webshield restart
   ```
   </div>
3. Check that the <span class="notranslate">`OPTIONS`</span> method is disabled correctly by running the following command:
   <div class="notranslate">

   ```shell
   curl -i -X OPTIONS http://[server IP]:52224
   ```
   </div>

   You should get the following status code:
   <div class="notranslate">

   ```
   HTTP/1.1 403 Forbidden
   ```
   </div>

