---
title: Hosting Panels Firewall Rulesets Specific Settings & ModSec
meta:
  - name: description
    content: Discover Hosting Panels Firewall Rulesets specific settings including modsec rules in Imunify360 security suite.
---

# Hosting Panels Firewall Rulesets Specific Settings & ModSec

[[toc]]

This section includes specific settings for each hosting panel that Imunify360 supports. It is important to follow these instructions to setup Imunify360 plugin properly.

::: tip Note
<span class="notranslate">mod_security</span>, the important software for Imunify360, is not installed automatically during Imunify360 installation process. Without <span class="notranslate">mod_security</span>, Imunify360 will lack the following features:

* Web application firewall
* Malware scanning of files uploaded using web
:::

<span class="notranslate">Mod_security</span> installation process is specific for different panels:

* Find the official cPanel documentation [here](https://documentation.cpanel.net/display/EA4/Apache+Module%3A+ModSecurity#ApacheModule:ModSecurity-InstallModSecHowtoinstalloruninstallmod_security2)

* Find the official Plesk documentation [here](https://docs.plesk.com/en-US/onyx/administrator-guide/server-administration/web-application-firewall-modsecurity.73383/)

::: danger Important!
If <span class="notranslate">mod_security</span> is installed after Imunify360, it is important to execute the following command to add <span class="notranslate">mod_security</span> ruleset to Imunify360:

For cPanel/Plesk/DirectAdmin/Stand-alone:

<div class="notranslate">

```
imunify360-agent install-vendors
```
</div>

:::

If <span class="notranslate">mod_security</span> is installed before Imunify360, the rules will be installed automatically.

::: tip Note
If Imunify360 installer detects any existing ruleset, it installs only minimal set of its rules. So, you need to disable all third-party rulesets prior to Imunify360 installation to get the full ruleset installed automatically.
:::

## cPanel

It is possible to enable <span class="notranslate">Service Status</span> checker for Imunify360. To do so, perform the following steps:

1. Go to <span class="notranslate">_Service Configuration_</span> and choose <span class="notranslate">_Service Manager_</span>.

2. In <span class="notranslate">_Additional Services_</span> section tick <span class="notranslate">`imunify360`</span> and <span class="notranslate">`imunify360-webshield`</span> checkboxes.

3. Click <span class="notranslate">_Save_</span> and wait until cPanel enables the <span class="notranslate">Service Status</span> checker for Imunify360.

![](/images/cpanel_set01.png)

If succeeded, the status of Imunify360 service will be displayed at <span class="notranslate">Service Status</span> section of <span class="notranslate">Server Status</span>.

![](/images/cpanel_set02.png)

### ModSecurity Settings

:::warning Note
Since version 92, cPanel is adding experimental support of ModSecurity 3.x and starting from version 5.7, we implement **experimental** support of ModSecurity version 3 on cPanel. Since the support is experimental, there are some limitations. Please find them [here](/hosting_panels_specific_settin/#modsecurity-3-apache-limitations).
:::
 
Recommended <span class="notranslate">mod_security</span> settings are:

* <span class="notranslate">Audit Log Level – Only log noteworthy transactions</span>
* <span class="notranslate">Connections Engine – Do not process the rules</span>
* <span class="notranslate">Rules Engine – Process the rules</span>

![](/images/modsecuritysettings.png)

It’s also recommended to disable any third-party <span class="notranslate">mod_security</span> vendors except Imunify360 ruleset (especially **OWASP** and **Comodo** ). These rulesets can cause large number of false-positives and duplicate Imunify360 ruleset.

To do so, go to <span class="notranslate">ModSecurity Vendors</span> section of cPanel main menu, and switch to <span class="notranslate">`Off`</span> all enabled vendors except Imunify360 ruleset.
If there is no Imunify360 ruleset installed, run <span class="notranslate">` imunify360-agent install-vendors`</span> command.

![](/images/ModSecVendors.png)

* Enable rules auto-update. Otherwise, you won't get important updates of ModSecurity ruleset in time
    * For Apache run the following command:
    
        <div class="notranslate">
 
        ```
        /usr/local/cpanel/scripts/modsec_vendor enable-updates imunify360-full-apache
        ```
        </div>
    * For LiteSpeed run the following command:
    
        <div class="notranslate">
 
        ```
        /usr/local/cpanel/scripts/modsec_vendor enable-updates imunify360-full-litespeed 
        ```
        </div>

    See details [here](https://documentation.cpanel.net/display/82Docs/ModSecurity+Vendors#ModSecurityVendors-Enableordisableupdates).

    Or you can use [WHMAPI1](https://documentation.cpanel.net/display/DD/WHM+API+1+Functions+-+modsec_enable_vendor_updates) to enable vendor auto-updates.

* It is possible to block ModSecurity rules only for IPs that belong to some country. More info can be found in [FAQ](/faq_and_known_issues/#_9-disabling-waf-rules-for-certain-countries)

### ModSecurity 3 + Apache limitations

Since version 92, cPanel is adding experimental support of ModSecurity 3.x and starting from version 5.7, we implement **experimental** support of ModSecurity version 3 on cPanel. There are still some issues that prevent some Imunify360 features from working property. The feature limitations are:

* working with mod_ruid2
* working with mod_remoteip
* app-specific ruleset feature
* HackerTrap
* uploaded files scanning
* simple password redirect

## Plesk

It is not recommended to use firewalld and Plesk Firewall simultaneously, because Plesk does not fully support such configuration. We recommend to disable firewalld by running the command on the server:

<div class="notranslate">

```
systemctl disable firewalld
```

</div>

Read more about the problem at Plesk Help Center in this [thread](https://support.plesk.com/hc/en-us/articles/115000905285-Plesk-Firewall-and-firewalld).

### ModSecurity Configuration

* <span class="notranslate">Web application firewall mode – On</span>

![](/images/modsecurityconfigurationpleskonyx.png)

If any <span class="notranslate">mod_security</span> ruleset was installed during Imunify360 installation, Imunify360 will not install its own ruleset, because Plesk supports only one ruleset at once.

To check, if Imunify360 ruleset is installed, run the following as root:

<div class="notranslate">

``` bash
# plesk sbin modsecurity_ctl -L --enabled
custom
```

</div>

If the output does not contain imunify360, for example:

<div class="notranslate">

``` bash
# plesk sbin modsecurity_ctl -L --enabled
tortix
```

</div>

Then remove existing ruleset and install Imunify360 one:

<div class="notranslate">

``` bash
# plesk sbin modsecurity_ctl --disable-all-rules --ruleset tortix
# plesk sbin modsecurity_ctl --uninstall --ruleset tortix
# plesk sbin modsecurity_ctl -L --enabled
# imunify360-agent install-vendors
INFO    [+ 3785ms]                         defence360agent.simple_rpc|Executing ('install-vendors',), params: {}
INFO    [+ 8781ms]   defence360agent.subsys.panels.plesk.mod_security|Successfully installed vendor 'imunify360-full-apache'.
INFO    [+ 8782ms]                  defence360agent.subsys.web_server|Performing web_server graceful restart
OK
# plesk sbin modsecurity_ctl -L --enabled
custom
```

</div>

::: tip Note
Please make sure that <span class="notranslate">_Update rule sets_</span> option is disabled in your Plesk <span class="notranslate">_Web Application Firewall_</span> interface on the <span class="notranslate">_Settings_</span> tab.
:::
::: tip Note 
Note that in the current version of Plesk, <span class="notranslate">_Update rule sets_</span> option is available if one of the <span class="notranslate">_Atomic Basic ModSecurity/Advanced ModSecurity Rules by Atomicorp/Comodo ModSecurity_</span> Rule Set is enabled.
:::


## DirectAdmin


During installation on DirectAdmin, Imunify360 will try to install <span class="notranslate">mod_security</span> automatically using custombuild 2.0.

::: tip Note
Automatic installation of Imunify360 ruleset is only supported with custombuild 2.0.
:::


