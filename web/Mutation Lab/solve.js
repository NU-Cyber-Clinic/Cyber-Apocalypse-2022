const express = require('express')
const session = require('cookie-session')
const app = express()
const port = 3000

app.use(session({
  name: 'session',
  keys: ['5921719c3037662e94250307ec5ed1db']
}))

app.get('/', (req, res) => {
  req.session.username = 'admin'
  res.send('Check your cookies')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
