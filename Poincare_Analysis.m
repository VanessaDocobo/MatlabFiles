close all 
#next 3 lines are there to change the rate to be at least 60bpm so values can be compared independent of HR 
ANN=locs;
med=median(diff(locs));
locs=locs/(med/500);
##-----------------------------------------------
subplot(1,3,1)
dlocs=[0;(diff(locs))];
ddlocs=[0;diff(dlocs)];
plot(dlocs,ddlocs,'x');
clc 
[ClusterNum,grids,ClusterMonitor]=NumberOfClusterInA2DMatrix(dlocs, ddlocs);
title(sprintf("index %d     CclusterNum %d  Clusterdensity %d",st,ClusterNum,mean(grids(find(grids>0)))));
grid on   

clc 
ClusterMonitor


ClusterArea=zeros(1,ClusterNum);
ClusterDensity=zeros(1,ClusterNum);
ClusterPopulation=zeros(1,ClusterNum);
for(i=1:ClusterNum)
CurrentClusterIndex=(find(ClusterMonitor==i));
ClusterArea(i)=length(CurrentClusterIndex);
ClusterPopulation(i)=sum(grids(CurrentClusterIndex));
end 
ClusterDensity=ClusterPopulation./ClusterArea;
irregIrreg=0;
if((max(ClusterArea)>10) ||  ((ClusterNum>8)  && (max(ClusterDensity)<3)) )
irregIrreg=1;
title("Irregularly Irreg");
else 
title("Reg or Reg Irreg");
end 

##title(ClusterDensity');


subplot(1,3,2)
[binNum,binsdlocs]=RRIntervalBinNumber(dlocs);
##title(corr(sort(diff(locs))));
title(binsdlocs);
maxBindlocs=max(binsdlocs);
binNumdlocs=binNum;
binDensitydlocs=sum(binsdlocs)/binNum;
title(length(find((binsdlocs)>(0.5*binDensitydlocs)))/sum(binsdlocs>0));
title(max(binsdlocs)/length(locs));
##title(var(bins));
subplot(1,3,3)
[binNum,binsddlocs]=RRIntervalBinNumber(ddlocs);
maxBinddlocs=max(binsddlocs);
binNumddlocs= binNum;
binDensityddlocs=sum(binsddlocs)/binNum;
##title(corr(sort(locs)));
##title(var(binsddlocs));
title(length(find((binsddlocs)>(0.5*binDensityddlocs)))/sum(binsddlocs>0));
title(max(binsddlocs)/length(locs));
##title(sprintf("Bin Num- % d BinDensity - %d", binNumddlocs,binDensityddlocs));