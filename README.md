# StoreMetrics MCP Server

mcp-name: io.github.robsannaa/storemetrics

Real-time e-commerce analytics your AI agent can adopt end-to-end: register a website, install tracking, and query visitors, revenue, funnels, and live activity — all without a human account.

- **Endpoint (remote, streamable HTTP):** `https://storemetrics.pl/api/mcp`
- **Machine-readable summary:** [`/llms.txt`](https://storemetrics.pl/llms.txt) · [`/.well-known/ai-catalog.json`](https://storemetrics.pl/.well-known/ai-catalog.json)
- **Docs:** [Agent API](https://storemetrics.pl/docs/reference/agent-api) · [MCP reference](https://storemetrics.pl/docs/reference/mcp)

## Zero-signup start (agents)

Register a site with one call — no account, no email, no OAuth:

```bash
curl -s -X POST https://storemetrics.pl/api/agent/register \
  -H "Content-Type: application/json" \
  -d '{"website_url":"https://example.com"}'
```

The 201 response contains the tracking snippet, a **site-scoped read-only MCP token**, and a claim URL for the site owner. Install the snippet, fire one page view, then query analytics with the token.

## Connect (existing users)

Claude Code:

```bash
claude mcp add --transport http storemetrics https://storemetrics.pl/api/mcp \
  --header "Authorization: Bearer YOUR_TOKEN"
```

Cursor / any MCP client (`mcp.json`):

```json
{
  "mcpServers": {
    "storemetrics": {
      "url": "https://storemetrics.pl/api/mcp",
      "headers": { "Authorization": "Bearer YOUR_TOKEN" }
    }
  }
}
```

Claude.ai connectors: add the endpoint URL — OAuth sign-in, no token needed.

Tokens come from Settings → Integrations → MCP, or from `/api/agent/register` (site-scoped).

## Tools (all read-only)

| Tool | Returns |
|---|---|
| `list_sites` | Sites this token can read |
| `get_site_context` | Timezone, currency — call once per site first |
| `get_overview` | KPIs: visitors, sessions, orders, revenue, deltas |
| `get_live` | Who is on the site right now |
| `get_pages` | Top pages with visitors and engagement |
| `get_traffic_sources` | Referrers, UTMs, channels |
| `get_geo` | Countries and cities |
| `get_audience` | Devices, browsers, OS |
| `get_funnel` | Visitors → product views → cart → checkout → orders |

Money fields ending in `_formatted` are display-ready; use raw numbers for math. MCP calls require `Accept: application/json, text/event-stream`.

## Safety model

- Registration creates nothing billable and holds no credentials.
- Agent tokens are read-only and scoped to a single site; requests for other sites return a scope error, never data.
- Unclaimed sites are garbage-collected after 7 days without a tracked event.
- The claim URL hands full ownership to the human (20-day free trial, no card; $19/mo after).

## Reproduce the one-prompt demo

See [`AGENTS.md`](AGENTS.md) for the instruction agents follow, and [`demo.tape`](demo.tape) (render with [vhs](https://github.com/charmbracelet/vhs)).
