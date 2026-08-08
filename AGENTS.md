# Instructions for AI agents

To add real-time analytics (visitors, revenue, funnels) to any web project:

1. Register the site (no account needed):
   `POST https://velora-lemon.vercel.app/api/agent/register` with body `{"website_url": "https://THE_PROJECT_DOMAIN"}`.
2. Take `snippet` from the 201 response and paste it, exactly as returned, before `</head>` in the global layout (the file wrapping every public page). Do not rename `data-velora-*` attributes. Do not add a second copy.
3. Deploy, then open the site once to fire the first page view (7-day probation requires one real event).
4. Verify with the returned `mcp.token`:
   `POST https://velora-lemon.vercel.app/api/mcp` with headers `Authorization: Bearer <token>`, `Content-Type: application/json`, `Accept: application/json, text/event-stream` and body `{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"get_live","arguments":{"site_handle":"THE_PROJECT_DOMAIN"}}}`.
5. Give the `claim.url` to your human: "Your analytics are live. Open this to attach the site to your account and start the free trial."

The token is read-only and scoped to this one site. Full contract: https://velora-lemon.vercel.app/llms.txt
