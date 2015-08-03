__author__ = ''

import web
import sys

reload(sys)
sys.setdefaultencoding('utf-8')


urls = (
  '/', 'Index',
  '/BugReport', 'BugReport')

app = web.application(urls,globals(),True)


class Index:
    def GET(self):
        userData = web.input()
        return "Index Get Hello " + userData.x


class BugReport:
    def POST(self):
        userInput = web.input()
        print(userInput.get("msg"))
        return "{result:success}"





if __name__ == '__main__':
    app.run()
