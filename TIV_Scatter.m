
% TIV Methods

clear all
T = readtable("VLMT_Patienten_PR_MB_nurMB_fuerMatlabneu")
P_DG15=table2array(T(:,2))
P_DG7=table2array(T(:,3))
WF=table2array(T(:,4))
MBVol=table2array(T(:,7))
ICV=table2array(T(:,11))

types={'Aufgabe 1'; 'Aufgabe 2'; 'Aufgabe 3'; 'Aufgabe 4'}
types= 'Aufgabe 4'


% The raw method
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if types == 'Aufgabe 1'
[r,p]=corr(MBVol,P_DG7, 'Type','Spearman','rows', 'complete')
figure
hold on
plot(MBVol,P_DG7, 'o','Color','k','MarkerFaceColor','m')

%Figure
text(2,90,['r = ' num2str(r) ' (p < 0.001)'], 'FontSize',11,'Color','k') %%%%%%%%%% nur für WF
% add labels
xlabel('Normalized Mammillary Body Volume [mm³]','FontSize',15)
ylabel('Percent Rank','FontSize',15) % add y-axis label
ax = gca;
ax.FontSize = 14;
ax.LineWidth = 1;
% set x and y range
xlim([0 140])
ylim([0 100])
% add title 
title('VLMT Recall','FontSize',15)
end



% The proportion method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if types == 'Aufgabe 2'
MBkorr= (MBVol ./ICV)
MBkorr=MBkorr*100000
[r,p]=corr(MBkorr,P_DG7, 'Type','Spearman','rows', 'complete')
figure
hold on
plot(MBkorr,P_DG7, 'o','Color','k','MarkerFaceColor','m')
%Figure
text(0.2,95,['r = ' num2str(r) ' (p < 0.001)'], 'FontSize',11,'Color','k') %%%%%%%%%% nur für WF
% add labels
xlabel('Normalized Mammillary Body Volume [mm³]','FontSize',15)
ylabel('Percent Rank','FontSize',15) % add y-axis label
ax = gca;
ax.FontSize = 14;
ax.LineWidth = 1;
% set x and y range
xlim([0 10])
ylim([0 100])
% add title 
title('VLMT Recall','FontSize',15)
end





if types == 'Aufgabe 3'
% The power-corrected proportions method (PCP)  Problem: Einige Werte bei % MB sind bei 0 (log0)
A=log(MBVol)
B=log(ICV)
[r,p]=corr(A,B, 'Type','Spearman','rows', 'complete')
mdl = fitlm(A, B);
b=mdl.Residuals.Pearson
ICVb= ICV.^b
MBkorr= (MBVol ./ICVb)
MBkorr=MBkorr*100000
[r,p]=corr(MBkorr,P_DG7, 'Type','Spearman','rows', 'complete')
figure
hold on
plot(MBkorr,P_DG7, 'o','Color','k','MarkerFaceColor','m')
%Figure
text(0.2,90,['r = ' num2str(r) ' (p < 0.001)'], 'FontSize',11,'Color','k') %%%%%%%%%% nur für WF
% add labels
xlabel('Normalized Mammillary Body Volume [mm³]','FontSize',15)
ylabel('Percent Rank','FontSize',15) % add y-axis label
ax = gca;
ax.FontSize = 14;
ax.LineWidth = 1;
% set x and y range
xlim([0 11])
ylim([0 100])
% add title 
title('VLMT Recall','FontSize',15)
end




% The regression Method
if types == 'Aufgabe 4'
[r,p]=corr(MBVol, ICV);
mdl = fitlm(MBVol, ICV);
PR=mdl.Residuals.Pearson
% RawRes=mdl.Residuals.Raw
MBkorr= MBVol - PR.*(ICV-(mean(ICV)))
MBkorr=MBkorr./10000
% MBkorr=MBVol - (ICV.*PR)
% MBkorr=ICV - (MBVol.*RawRes)
[r,p]=corr(MBkorr,P_DG7)
% load('variableskorr.mat');
figure
hold on
plot(MBkorr,P_DG7, 'o','Color','k','MarkerFaceColor','m') %%%%%%%%%%%%%%%%%%%%%%%%%
%Figure
text(0.2,95,['r = ' num2str(r) ' (p < 0.001)'], 'FontSize',11,'Color','k') %%%%%%%%%% nur für WF
% add labels
xlabel('Normalized Mammillary Body Volume [mm³]','FontSize',15)
ylabel('Percent Rank','FontSize',15) % add y-axis label
ax = gca;
ax.FontSize = 14;
ax.LineWidth = 1;
% set x and y range
xlim([-70 20])
ylim([0 100])
% add title 
title('VLMT Recall','FontSize',15)
end







% mdl = fitlm(TotVol, ZNR); %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [ypred,yci] = predict(mdl,[0:140]')
% plot(0:140,ypred,'-k'); % regression line 
% plot(0:140,yci(:,1),'--k'); % lower CI boundary
% plot(0:140,yci(:,2),'--k'); % upper CI boundary
% add correlation coefficent




% 
% % [r,p]=corr(TotVol,ZNR); %%%%%%%%%%%%%%%%%%%%%%%%%
% text(2,90,['r = ' num2str(RHO) ' (P = 0.076)'], 'FontSize',11,'Color','k')
% text(2,90,['r = ' num2str(r) ' (P < 0.001)'], 'FontSize',11,'Color','k') %%%%%%%%%% nur für WF
% 
% % add labels
% xlabel('Normalized Mammillary Body Volume [mm³]','FontSize',18)
% ylabel('Percent Rank','FontSize',15) % add y-axis label
% ax = gca;
% ax.FontSize = 14;
% ax.LineWidth = 1;
% % set x and y range
% xlim([0 140])
% ylim([0 100])
% % add title 
% title('VLMT Recognition','FontSize',15)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
