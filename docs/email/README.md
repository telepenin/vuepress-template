# Email


## Installation

:::danger Note
Hosting administrator only.
:::

:::danger Important
Imunify Email beta is available for installation for registered beta testers only. Make sure you have subscribed as beta tester using [https://imunifyemail.com/](https://imunifyemail.com/) and followed the instructions sent by email.
:::

Imunify Email Beta is simple to install. 

At the moment, it runs on the following distributions:

* CentOS 7,8 with support of cPanel/WHM control panel.
* CloudLinux OS 7,8 with support of cPanel/WHM control panel. 

Minimum system requirements for installation:
* x64 | 512 Mb** | 20 Gb disk space ***

:::tip Note
** Imunify Email RAM consumption depends on the mail traffic. In a waiting state it consume little RAM, however for scanning large mails temporary increase of RAM consumption can be observed.

*** Used disk space depends on the number of accounts on a server. By default, each account will have 100 MB limitation for quarantine space. This limit can be adjusted using UI later.
:::

To install Imunify360, open an SSH connection to your server using your preferred SSH console application. You will need to have the root level access in order to proceed.

To start installation, run the following script with your activation key:

```
wget https://repo.imunify360.cloudlinux.com/defence360/imunifyemail-deploy.sh
bash imunifyemail-deploy.sh
```

### Installation details

#### Users created

During installation, the following users will be created: 

* _rspamd
* _imunifyemail

The `_imunifyemai` user will also be added to the `_imunify` group.

#### Directories

Imunify Email has following components:

* Imunify RSpamd 
* Imunify Quarantine 

Imunify RSpamd acts as an email filter and is installed in system directories such as:

* /etc/rspamd
* /usr/bin
* /usr/lib
* /usr/share/rspamd

Imunify Quarantine is installed in the following directory: `/var/imunifyemail/quarantine`.

#### Quarantine directories

Imunify Quarantine component keeps all quarantine content, including emails and meta data in the following directory: 
`/var/imunifyemail/quarantine/storage/`.


### Exim configuration modifications

Imunify Email modifies Exim MTA configuration, adding RSpamd as a filter for email. 
It is done automatically during installation. In case if filtering needs to be disabled, see [Disable Imunify Email](/email/#disable-imunify-email). When disabled, Exim configuration will not contain an RSpamd filter. To re-able Imunify Email, see [Enable Imunify Email](/email/#enable-imunify-email).

The configuration change is compatible with WHM Advanced Editor, you can continue using it for other modifications. 

## User interface access

In order to access the UI as a hosting administrator, navigate to WHM -> Plugins -> Imunify360 -> Email tab. 

Your clients will be able to access the Imunify Email Quarantine under: cPanel -> Security -> Imunify360 -> Email.

## Managing Imunify Email

#### Check status

In order to check status of Imunify Email, run the following command as root:

```
imunifyemail-config status
```

#### Disable Imunify Email

In order to disable Imunify Email, run following command as root:

```
imunifyemail-config disable
```

It will remove filter configuration and stop Imunify Email services.


#### Enable Imunify Email

If Imunify Email was installed, but then disabled it can be re-enabled using the following command, run as root: 

```
imunifyemail-config enable
```


## WHM user interface

:::danger Note
Hosting administrator only.
:::

Imunify Email scans the outbound emails on the server and allows to identify viral mailings and other viral outbound mail content for all accounts on the server.

Click <span class="notranslate">_Email_</span> in the main menu of the Imunify360 admin interface.

![](/images/EmailMain.png)

The following tabs are available:

* <span class="notranslate">[Quarantine](/email/#quarantine)</span>
* <span class="notranslate">[Settings](/email/#settings)</span>

## Quarantine

Go to <span class="notranslate">Imunify360 → Email → Quarantine</span> tab. Here, there are emails that are considered viral or malicious for all accounts on the server. You can decline or confirm the Imunify Email decision and either release and send emails or remove them completely.

![](/images/EmailQuarantineTab.png)

The table has the following columns:

* <span class="notranslate">**Account**</span> — account name
* <span class="notranslate">**Received Date**</span> — when an email was received by the server for sending
* <span class="notranslate">**Sender (From)**</span> — the user who sent the email
* <span class="notranslate">**Recipients**</span> — recipients (including CC and BCC)
* <span class="notranslate">**Subject**</span> — a subject from an email
* <span class="notranslate">**Actions**</span>
  * <span class="notranslate">**Release & Send**</span> — hosting admin can use multi-select and release & send several emails at once

   ![](/images/EmailRelease.png)

  * <span class="notranslate">**Delete**</span> — delete email permanently

    ![](/images/EmailDelete.png)

  * <span class="notranslate">**View Email**</span> — view email content

    ![](/images/EmailView1.png)

    * Body - decoded email content with tags removed
    * Header - email Headers section
    * Plain text - headers plus original email body

:::tip Note
In this Beta release, the notifications are not sent both when deleting or releasing an email. Will be added in the next release.
:::

## Settings

:::danger Note
Hosting administrator only.
:::

Go to <span class="notranslate">Imunify360 → Email → Settings</span> tab. The settings allow managing the space for quarantine. An administrator can increase or decrease the space for the user's quarantine. If all space is consumed, the oldest emails in quarantine will be permanently deleted.

:::danger Note
By default, the space for the user's quarantine is 100 MB.
:::

![](/images/EmailSettings.png)

The table has the following columns:

* <span class="notranslate">**Account**</span> — user account name
* <span class="notranslate">**Limit (MB)**</span> — the space for the user's quarantine limit (default is 100 MB)
* <span class="notranslate">**Used Space (MB)**</span> — the space used by files in quarantine (slight excess of the limit is possible)
* <span class="notranslate">**State**</span> — the state of the user's quarantine. In the Beta version it is **Active** only
* <span class="notranslate">**Details**</span> — emails deleted permanently for the last hour
* <span class="notranslate">**Actions**</span>
  * <span class="notranslate">**Purge quarantine**</span> — purge all quarantine for an account

    ![](/images/EmailPurge.png)

  * <span class="notranslate">**Add**</span> — change the limit of the space for the user's (account) quarantine

   ![](/images/EmailAdd.png)