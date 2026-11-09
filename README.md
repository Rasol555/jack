# 3x-ui روی Railway (نصب با یک کلیک)

## ساخت Template در Railway (یک بار)

1. این پوشه را به‌صورت ریپوی GitHub آپلود کن (شش فایل در ریشه).
2. در Railway: Account/Workspace ← **Templates** ← **New Template**.
3. **Add Service ← GitHub Repo** و ریپو را انتخاب کن.
4. در تنظیمات سرویس:
   - **Variables** را اضافه کن:
     - `XUI_USER` = `admin`
     - `XUI_PASS` = `${{secret(16)}}`
     - `PANEL_PATH` = `${{secret(8, "abcdefghijklmnopqrstuvwxyz")}}`
     - `WS_PATH` = `${{secret(8, "abcdefghijklmnopqrstuvwxyz")}}`
   - **Volume** اضافه کن با Mount Path: `/etc/x-ui`
   - **Networking**: Public Networking (Generate Domain) را فعال کن.
5. **Create Template** و بعد Publish.
6. دکمه Deploy از لینک `https://railway.com/deploy/کد-تمپلیت` ساخته می‌شود.

## بعد از Deploy
1. Deployments ← View Logs. بین خطوط `====` یک **VLESS LINK** چاپ می‌شود؛ کپی و در v2rayNG/Hiddify وارد کن.
2. رمز و مسیر پنل را از تب **Variables** ببین (`XUI_PASS` و `PANEL_PATH`).
3. آدرس پنل: `https://دامنه/PANEL_PATH/`

اگر در لاگ پیام `init-inbound: ... failed` دیدی، inbound را دستی بساز:
VLESS، Listen `127.0.0.1`، Port `10000`، Transport `ws`، Path `/WS_PATH`، Security `none`.
