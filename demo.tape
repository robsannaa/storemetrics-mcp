# Render with: vhs demo.tape  (https://github.com/charmbracelet/vhs)
Output demo.gif
Set FontSize 16
Set Width 1200
Set Height 700
Set TypingSpeed 40ms
Type "# Add analytics to a project - no signup, one call"
Enter
Sleep 1s
Type `curl -s -X POST https://storemetrics.pl/api/agent/register -H "Content-Type: application/json" -d '{"website_url":"https://demo-store.example.com"}' | jq .`
Enter
Sleep 4s
Type "# snippet -> layout <head>, deploy, open the site once..."
Enter
Sleep 2s
Type `curl -s -X POST https://storemetrics.pl/api/mcp -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -H "Accept: application/json, text/event-stream" -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"get_live","arguments":{"site_handle":"demo-store.example.com"}}}'`
Enter
Sleep 4s
Type "# Live. Hand the claim URL to your human."
Enter
Sleep 2s
