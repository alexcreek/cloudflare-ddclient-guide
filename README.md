# Cloudflare DDclient Guide
How to update Cloudflare DNS with DDclient

I had a need to use DNS for a personal project and went down the rabbit hole of dynamic DNS.  Instead of using a DDNS provider, I settled on hosting a zone in Cloudflare and using ddlclient to keep a record up-to-date.

I found some stuff online about using ddclient with Cloudflare but it took some hacking to get everything working.

## Gotchas Discovered
- Cloudflare deprecated the API that ddclient originally used -- https://www.cloudflare.com/migrating-to-v4/
- The version of ddclient in the ubuntu focal repo (3.8.3) still uses Cloudflare's deprecated API.  To get the latest version, you have to install ddclient from Github.

## Setup
It's assumed the reader has a Cloudflare account and a DNS zone.

1. Create the DNS record you want to manage with ddclient.
1. Create a Cloudflare API token using the `Edit Zone DNS` template.  For `Zone Resources` select `All zones` - https://developers.cloudflare.com/api/tokens/create
1. Clone this repo
```
git clone https://github.com/alexcreek/cloudflare-ddclient-guide.git ddclient
cd ddclient
```
1. Update the following in [ddclient.conf](/ddclient.conf). Here's some config examples from the [source](https://github.com/ddclient/ddclient/blob/develop/ddclient.in#L5489-L5516)
    - password=
    - zone=
    - RECORD_TO_UPDATE
1. Start the ddclient container.
```
docker-compose up -d
```
## Validation
Check ddlient's logs for SUCCESS messages.

`docker-compose logs -f ddclient` should yield:

```
SUCCESS:  $record -- Updated Successfully to $ip
```

## Troubleshooting
- To enable verbose logging, in [ddclient.conf](/ddclient.conf) set `verbose=yes` then run `docker-compose restart ddclient` to restart the container.
- To execute commands from the project's [troubleshooting docs](https://github.com/ddclient/ddclient#troubleshooting), open a shell in the container by running `docker-compose exec ddclient bash`
