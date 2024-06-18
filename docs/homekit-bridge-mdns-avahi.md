How I got HomeKit working with my Docker version of HomeAssistant using Avahi for mDNS:

1. Run the Avahi container (included in my compose yaml files)
2. Add the `homekit:` config lines to HomeAssistant's `configuration.yaml` file (view appdata folder in repo)
3. Restart HomeAssistant so that HomeKit gets added as application, you will see the QR code to setup in the Notifications within HomeAssistant.
4. `pip install zeroconf`
5. Now run hap.py (in my scripts folder)
6. The script will output a list of _hap._tcp. services, find the one that matches your HomeAssistant instance and take a copy.
7. Now create a hap.service file inside your avahi container's appdata folder (see my example in appdata)
8. Restart the Avahi container and you should now be able to add the HomeKit bridge to your Home app on iOS.

You can view _hap._tcp. services by using the App Store app on iOS called "Discovery - DNS-SD Browser" and searching for `_hap._tcp.`.