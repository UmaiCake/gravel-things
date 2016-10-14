# -*- coding: utf-8 -*-
import tweepy
import json
import re
import pyperclip
import threading
import Tkinter
import winsound
 
canCopy=0
sndNotif=0
class TwitterStreamListener(tweepy.StreamListener):
   
    def on_data(self, data):
        json_load = json.loads(data)
        texts = json_load['text']
        coded = texts.encode('utf-8')
        st = str(coded)
        m = re.search('ID：([A-z0-9]{8})', st)
        m2 = re.search('ID: ([A-z0-9]{8})', st)
        print "\n"
        print st
        if m:
            found = m.group(1)
            if canCopy==1:
                pyperclip.copy(found)
            if sndNotif==1:
                winsound.PlaySound('sound.wav', winsound.SND_FILENAME)
        if m2:
            found = m2.group(1)
            if canCopy==1:
                pyperclip.copy(found)
            if sndNotif==1:
                winsound.PlaySound('sound.wav', winsound.SND_FILENAME)
        return True
 
    def on_error(self, status):
        print status
        return False
 
class simpleui(Tkinter.Tk):
    def __init__(self,parent):
        Tkinter.Tk.__init__(self,parent)
        self.parent = parent
        self.initialize()
    def initialize(self):
        self.copying=Tkinter.IntVar()
        self.snd=Tkinter.IntVar()
        self.button1 = Tkinter.Checkbutton(self, variable=self.copying, onvalue=1, offvalue=0, text='Auto-copy?',command = self.changeCp)
        self.button2 = Tkinter.Checkbutton(self, variable=self.snd, onvalue=1, offvalue=0, text='Toggle sound',command = self.changeSnd)
        self.button1.pack()
        self.button2.pack()
    def changeCp(self):
        global canCopy
        canCopy=self.copying.get()
        if self.copying.get()==1:
            print "\nAuto-copying enabled"
        if self.copying.get()==0:
            print "\nAuto-copying disabled"
    def changeSnd(self):
        global sndNotif
        sndNotif=self.snd.get()
        if self.snd.get()==1:
            print "\nSound enabled"
        if self.snd.get()==0:
            print "\nSound disabled"
 
 
def init_stream():
    consumer_key = 'WLBbseWknPnmyNWVT7SzRgoW0'
    consumer_secret = '2Ec0ScZqLRVgQ1ShsY4ZF5cO8mFeJcDwRMYdEoKHWYCZClBeih'
    access_token = '2489247666-bISLnlvwoNFw4LKMg1o6n4RXZBa7ZkAFf3RtAHO'
    access_token_secret = 'JqEV2JSU6pFFMMDWEhguLDDKyNAt3HF1g77GsKV2RzNOY'
 
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.secure = True
    auth.set_access_token(access_token, access_token_secret)
    api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)
    streamListener = TwitterStreamListener()
    myStream = tweepy.Stream(auth=api.auth, listener=streamListener)
    myStream.filter(track=[u"____________"])
 
if __name__ == "__main__":
    app = simpleui(None)
    app.title('ID copier')
    t1 = threading.Thread(target=init_stream)
    t1.setDaemon(True)
    t1.start()
    app.mainloop()
