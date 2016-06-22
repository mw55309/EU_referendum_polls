
# create nice colours for Remain and Leave
library(RColorBrewer)
rl <- brewer.pal(n=3, "Set2")[c(1,3)]

# read the data
d <- read.csv("https://raw.githubusercontent.com/mw55309/EU_referendum_polls/master/data.csv", header=TRUE)

# extract dates
dates <- substr(d[,1], 1, regexpr("/", d[,1])-2)

# set up multi-panel plot
split.screen(c(2,1))

# top panel
screen(1)
par(mar=c(5,4,3,1))

# set up plot and plot remain line
plot(1:nrow(d), d$Remain, col=rl[1], lwd=2, type="l", ylim=c(35,75), xaxt="n", xlab="", ylab="Percentage", main="EU referendum voting intention: poll results")

# add date axis
axis(side=1, at=seq(1, nrow(d), by = 2), dates[seq(1, nrow(d), by=2)], las=2, cex.axis=0.8)

# add legend
legend(95, 70, legend=c("Remain","Leave"), fill=rl, bty="n", cex=0.8, pt.cex=0.8)

# add rest of data
points(1:nrow(d), d$Remain, col=rl[1], pch=16)
lines(1:nrow(d), d$Leave, col=rl[2], lwd=2)
points(1:nrow(d), d$Leave, col=rl[2], pch=16)

# bottom panel
screen(2)
par(mar=c(2,4,5,1))

# set colours for Remain and Leave
cols <- rep(rl[1], nrow(d))
cols[d$Remain - d$Leave < 0] <- rl[2]

# plot bars
barplot(d$Remain - d$Leave, col=cols, main="Lead for Remain", ylab="Percentage")

# close the screens
close.screen(all=TRUE)
