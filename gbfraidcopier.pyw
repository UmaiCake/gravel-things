# -*- coding: utf-8 -*-
import tweepy
import json
import re
import pyperclip
import threading
import tkinter
import winsound
import copy
import configparser

DEBUG=False

config = configparser.ConfigParser()
config.read('gbfraidcopier.cfg')


raidCount = 6
trk = [0]*raidCount
cpyOn = [0]*raidCount
sndOn = [0]*raidCount
names = [
    "Celeste Omega HL",
    "Colossus Omega HL",
    "Leviathan Omega HL",
    "Tiamat Omega HL",
    "Yggdrasil Omega HL",
    "Ultimate Bahamut",
    "Proto Bahamut",
    "The Grand Order",
    ]
enSearchStrings = [
    u"Lvl 100 Celeste Omega",
    u"Lvl 100 Colossus Omega",
    u"Lvl 100 Tiamat Omega Ayr",
    u"Lvl 100 Yggdrasil Omega",
    u"Lvl 150 Ultimate Bahamut",
    u"Lvl 100 Proto Bahamut",
    u"Lvl 100 The Grand Order",
    ]
jpSearchStrings = [
    u"Lv100 セレスト・マグナ",
    u"Lv100 コロッサス・マグナ",
    u"Lv100 ティアマト・マグナ＝エア",
    u"Lv100 ユグドラシル・マグナ",
    u"Lv150 アルティメットバハムート",
    u"Lv100 プロトバハムート",
    u"Lv100 ジ・オーダー・グランデ",
    ]
logtext = {}
idregex = re.compile(u'([A-Z0-9]{8})')

class TwitterStreamListener(tweepy.StreamListener):
    def on_data(self, data):
        json_load = json.loads(data)
        texts = json_load['text']
        coded = texts.encode('utf-8')
        st = str(coded, encoding='utf-8')

        #log(st)
		
        for i in range(0, raidCount):
            if (trk[i] or sndOn[i] or cpyOn[i]) and (st.find(enSearchStrings[i]) != -1 or st.find(jpSearchStrings[i]) != -1):
                m = idregex.search(st)
                if m:
                    found = m.group(1)
                    if trk[i]:
                        log(names[i] + ": " + found)
                    if cpyOn[i]:
                        pyperclip.copy(found)
                    if sndOn[i]:
                        winsound.PlaySound('sound.wav', winsound.SND_FILENAME)
                    
        return True

    def on_status(self, status):
        log("Twitter status: " + str(status))
 
    def on_error(self, status):
        if status == 420:
            log("Rate limited by twitter! Wait a little while and try again.")
        else:
            log("Unknown error! Check your internet connection and try again.")
            log("Error code: " + str(status))
        
        return False

class simpleui(tkinter.Tk):
    def __init__(self, parent):
        global logtext
        tkinter.Tk.__init__(self,parent)
        self.parent = parent
        self.copying = []
        self.sounds = []
        self.tracking = []
        self.all = []

        tkinter.Label(self, text='Raid').grid(row=0, column=0)
        for i in range(0, raidCount):
            tkinter.Label(self, text=names[i]).grid(row=i+1, column=0, stick=tkinter.W)

        trklabel = tkinter.Label(self, text='Show')
        trklabel.grid(row=0, column=1)
        for i in range(0, raidCount):
            var = tkinter.IntVar()
            self.tracking.append(var)
            tkinter.Checkbutton(self, variable=var, command=lambda i=i: self.changeTrk(i)).grid(row=i+1, column=1)

        cpylabel = tkinter.Label(self, text='Auto copy')
        cpylabel.grid(row=0, column=2)
        cpybtns = [{}] * raidCount
        for i in range(0, raidCount):
            var = tkinter.IntVar()
            self.copying.append(var)
            tkinter.Checkbutton(self, variable=var, command=lambda i=i: self.changeCpy(i)).grid(row=i+1, column=2)

        sndlabel = tkinter.Label(self, text='Alert')
        sndlabel.grid(row=0, column=3)
        for i in range(0, raidCount):
            var = tkinter.IntVar()
            self.sounds.append(var)
            tkinter.Checkbutton(self, variable=self.sounds[i], command=lambda i=i: self.changeSnd(i)).grid(row=i+1, column=3)

        tkinter.Label(self, text='All').grid(row=0, column=4)
        for i in range(0, raidCount):
            var = tkinter.IntVar()
            self.all.append(var)
            tkinter.Checkbutton(self, variable=var, command=lambda i=i: self.changeAll(i)).grid(row=i+1, column=4)

        logframe = tkinter.Frame(self)
        logframe.grid(row=0, column=5, rowspan=raidCount+1)
        scrollbar = tkinter.Scrollbar(logframe)
        scrollbar.pack(side=tkinter.RIGHT, fill=tkinter.Y)
        logtext = tkinter.Text(logframe, state=tkinter.DISABLED, yscrollcommand=scrollbar.set)
        logtext.pack()
        logtext.insert(tkinter.END, "what")

    def changeAll(self, i):
        state = self.all[i].get()
        self.tracking[i].set(state)
        self.copying[i].set(state)
        self.sounds[i].set(state)
        self.changeTrk(i)
        self.changeCpy(i)
        self.changeSnd(i)
    def changeTrk(self, i):
        global trk
        trk[i] = self.tracking[i].get()
        if trk[i]:
            log("Started showing " + names[i] + " tweets")
        else:
            log("Stopped showing " + names[i] + " tweets")
    def changeCpy(self, i):
        global cpyOn
        cpyOn[i] = self.copying[i].get()
        if cpyOn[i]:
            log("Started auto-copying " + names[i] + " tweets")
        else:
            log("Stopped auto-copying " + names[i] + " tweets")
    def changeSnd(self, i):
        global sndOn
        sndOn[i] = self.sounds[i].get()
        if sndOn[i]:
            log("Started notifying on " + names[i] + " tweets")
        else:
            log("Stopped notifying on " + names[i] + " tweets")
 

def log(text):
    def append():
        logtext.configure(state="normal")
        logtext.insert(tkinter.END, text+"\n")
        logtext.configure(state="disabled")
        logtext.yview(tkinter.END)
    logtext.after(0, append);

def init_stream():

    consumer_key = config.get('Keys', 'consumer_key')
    consumer_secret = config.get('Keys', 'consumer_secret')
    access_token = config.get('Keys', 'access_token')
    access_token_secret = config.get('Keys', 'access_token_secret')
 
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.secure = True
    auth.set_access_token(access_token, access_token_secret)
    api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)
    streamListener = TwitterStreamListener()
    stream = tweepy.Stream(auth=auth, listener=streamListener)
    stream.filter(track=enSearchStrings + jpSearchStrings)
    log("started")
	
 
if __name__ == "__main__":
    app = simpleui(None)
    app.title('ID copier')
    t1 = threading.Thread(target=init_stream)
    t1.setDaemon(True)
    t1.start()
    app.mainloop()
