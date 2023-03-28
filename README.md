# iOS-code-challenge-1

# Derek Kim - iOS Code Challenge 1 Submission

## Link(s): 
Github Repository: https://github.com/treasure3210/iOS-code-challenge-1

## Login Credential: 
ID: treasure3210+1@gmail.com
PW: K131313_!

## Note(s): 
I have used UICalendarView available native by Apple: https://developer.apple.com/documentation/uikit/uicalendarview

1) Since this is new since iOS 16+, there are many restrictions such as not supporting older iOS versions and not being able to customize as much as a custom created calendar, however I chose this because it’s offered by Apple themselves and can be used natively. 
2) LoginViewController (page 1) is done via Storyboard & ScheduleViewController (page 2) is done all programmatically.
3) Schedule is set to be shown on March 28, March 29, March 30, and March 31, and all other dates should display “There is no event”. Since the mockup endpoint did not provide which date in particular, I have set these dates to show the data only. This can be customized of course. 
4) Auto-layout checked up-to iPhone SE (3rd generation), smallest screen supported & available in Xcode.
5) No 3rd party packages or libraries imported.

## Endpoint(s):
I first started with mockup endpoints, but I wasn’t sure if calling the endpoints were valid or not, so I have simply used Firebase for authentication to receive actual JWT - access token and refresh token and JSONBin.io to store a simple JSON schedule data.

### [`POST`] User authentication: Firebase - 
Path: {customDomain}/api/login
https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${API_KEY}

### [`GET`] Calendar Data: JSONBin.io - 
Path: {customDomain}/api/schedule
if Success: https://api.jsonbin.io/v3/b/${SCHEDULE_JSONBIN_ID}/latest
if Fail: https://api.jsonbin.io/v3/b/${ERROR_JSONBIN_ID}/latest

#### All endpoints have been scripted and deployed to the serverless side using Cloudflare Workers.

#### Cloudflare Worker’s custom domain received: https://keys.treasure3210.workers.dev/

#### Test cases (Postman): https://www.postman.com/dark-firefly-850440/workspace/ios-code-challenge-1/overview
