getStdin = require 'get-stdin'
Airtable = require('airtable')
base = new Airtable(apiKey: 'keya5owBYIn0zRzxP').base('app2PLtM6KVLhzhrJ')

getStdin()
.then (entry) ->
  entry = JSON.parse entry
  airtableEntry =
    'Issue': entry.issue.number.toString()
    'Title': entry.issue.title
    'Repo': entry.repository.full_name
    'Priority': 'High'
    'Status': 'Backlog'
    'Bug Source': 'GitHub Issue'
    'Description': entry.issue.body
    'Notified Users?': true
.then (entry) ->
  base('Bugs & Issues')
    .create entry
    , (err, record) ->
      if err
        console.log err
        return
      console.log JSON.stringify(record: record.getId())
  return
.catch console.log.bind console
