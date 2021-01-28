$accountId = "(資料中のアカウントIDをご利用ください)"
$insertkey = "(控えておいたキー)"
# Replace with your custom event for the body
$body = '[{"eventType":"NRULab", "labnumber":1, "initial":"ご自身のイニシャルに書き換えてください", "comment":"任意の文字列を入れてください(日本語可)" }]'

$headers = @{} 
$headers.Add("X-Insert-Key", "$insertkey") 
$headers.Add("Content-Encoding", "gzip")


$encoding = [System.Text.Encoding]::UTF8
$enc_data = $encoding.GetBytes($body)

$output = [System.IO.MemoryStream]::new()
$gzipStream = New-Object System.IO.Compression.GzipStream $output, ([IO.Compression.CompressionMode]::Compress)

$gzipStream.Write($enc_data, 0, $enc_data.Length)
$gzipStream.Close()
$gzipBody = $output.ToArray()

Invoke-WebRequest -Headers $headers -Method Post -Body $gzipBody  "https://insights-collector.newrelic.com/v1/accounts/$accountId/events"

