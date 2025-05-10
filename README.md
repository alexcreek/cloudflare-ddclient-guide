# Cloudflare ddclient Guide
I wanted to use DNS for a personal project and went down the Dynamic DNS rabbit hole. I settled on hosting a DNS zone in Cloudflare and using ddclient to keep a record updated.

I found some info online for using ddclient with Cloudflare, but it took some hacking to get everything working.

### Gotchas Discovered
- Cloudflare [deprecated](https://www.cloudflare.com/migrating-to-v4/) the API that ddclient originally used.
- The version of ddclient in the ubuntu focal repo (3.8.3) still uses Cloudflare's deprecated API. To get the latest version, you have to install ddclient from Github.

## Usage
1. Have a Cloudflare account and DNS zone 
2. Create the DNS record ddclient should manage
3. Create a Cloudflare API token. Use the 'Edit Zone DNS' template. For 'Zone Resources' select 'All zones' ([ref](https://developers.cloudflare.com/api/tokens/create))
4. Clone this repo
5. Update the following in [ddclient.conf](/ddclient.conf).
    - password=
    - zone=
    - RECORD_TO_UPDATE
6. Start the ddclient container.
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
