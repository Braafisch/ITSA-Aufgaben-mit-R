#Lösung für 2 a)
t=time(1:200)
s=10*exp(-(t-100)/20)*cos(2*pi*t/4)
s[1:100]=0
w=rnorm(200)
x=s+w
par(mfrow=c(2,1))
ts.plot(x, main="Lösung für 2 a)")
#Lösung für 2 b)
t = time(1:200)
s = 10*exp(-(t-100)/200)*cos(2*pi*t/4)
s[1:100] = 0
w = rnorm(200)
x = s+w
ts.plot(x, main="Lösung für 2 b)")
