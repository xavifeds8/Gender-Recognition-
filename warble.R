library(warbleR)

setwd('D:/emotion_class')
current_wd<-getwd()
req_file <- file.path(current_wd,"output.wav")
sound <- readWave(req_file)
soundspec <- meanspec(sound, f = sound@samp.rate, plot = FALSE)
analysis <- specprop(soundspec, f = sound@samp.rate, flim = c(0, 280/1000), plot = FALSE)
centroid<-  analysis$cent/1000
mode <- analysis$mode/1000
ff <- seewave::fund(sound, f = sound@samp.rate, ovlp = 50, threshold = NULL, 
                    fmax = 280, ylim=c(0, 280/1000), plot = FALSE, wl = 512)[, 2]
meanfun<-mean(ff, na.rm = T)
minfun<-min(ff, na.rm = T)
maxfun<-max(ff, na.rm = T)
View(centroid)
View(meanfun)
track  = paste("output",sep="")
track  = paste(track,".wav",sep="")
X <- data.frame(sound.files=track,selec=0,start=0,end=1)
a <- specan(X, bp = c(0,22), wl = 512, threshold = 15)
View(a)
Final_data <- data.frame("meanfreq"=a["meanfreq"],"sd"=a["sd"],"median"=a["freq.median"],"Q25"=a["freq.Q25"],"Q75"=a["freq.Q75"],"IQR"=a["freq.IQR"],"skew"=a["skew"],"kurt"=a["kurt"],"sp.ent"=a["sp.ent"],"sfm"=a["sfm"],"mode"=mode,"centroid"=centroid,"meanfun"=meanfun,"minfun"=minfun,"maxfun"=maxfun,"meandom"=a["meandom"],"mindom"=a["mindom"],"maxdom"=a["maxdom"],"dfrange"=a["dfrange"],"modindx"=a["modindx"])
View(Final_data)
write.csv(Final_data, file='C:/Users/Padmashree/Documents/ML_projects/Linear_algebra/voicetest.csv', row.names=F)