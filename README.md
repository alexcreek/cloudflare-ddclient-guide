# Cloudflare ddclient Guide
How to update Cloudflare DNS with ddclient

I had a need to use DNS for a personal project and went down the rabbit hole of dynamic DNS.  Instead of using a DDNS provider, I settled on hosting a zone in Cloudflare and using ddclient to keep a record up-to-date.

I found some stuff online about using ddclient with Cloudflare but it took some hacking to get everything working.

## Gotchas Discovered
- Cloudflare [deprecated](https://www.cloudflare.com/migrating-to-v4/) the API that ddclient originally used.
- The version of ddclient in the ubuntu focal repo (3.8.3) still uses Cloudflare's deprecated API.  To get the latest version, you have to install ddclient from Github.

## Setup
It's assumed the reader has a Cloudflare account and a DNS zone.

1. Create the DNS record you want to manage with ddclient.
2. Create a Cloudflare API token using the `Edit Zone DNS` template.  For `Zone Resources` select `All zones`. [ref](https://developers.cloudflare.com/api/tokens/create)
3. Clone this repo.
```
git clone https://github.com/alexcreek/cloudflare-ddclient-guide.git ddclient
cd ddclient
```
4. Update the following in [ddclient.conf](/ddclient.conf).
    - password=
    - zone=
    - RECORD_TO_UPDATE
5. Start the ddclient container.
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
