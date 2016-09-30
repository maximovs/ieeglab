function [tsignificantMat,t,p] = wSMIStats(path,condition1,condition2,tau,channelNr,method,alpha)
%returns channelNr*channelNr statistical matrix with t values for selected
%method and be optionally be printed as .edge

%matrix C1 and C2 must have same size
[C1] = LoadwSMIConnectivityMatrix(path,condition1,tau,channelNr);

[C2] = LoadwSMIConnectivityMatrix(path,condition2,tau,channelNr);

significantMat = zeros(size(C1,1),size(C1,1));

 switch method    
        case 'ttest'
            %TTEST
            data1 = reshape(C1,[size(C1,1)*size(C1,2),size(C1,3)]);
            data2 = reshape(C2,[size(C2,1)*size(C2,2),size(C2,3)]);
            [h,p,ci,stats] = ttest2(data1',data2');
            t = reshape(stats.tstat,[size(C1,1),size(C1,2)]);
            p = reshape(p,[size(C1,1),size(C1,2)]);
        case 'boot'
            %BOOTSTRAP
            [t, df, p] = statcond( {C1,C2}, 'method','bootstrap','naccu',1000);
        case 'perm'
            %PERMUTATIONS
            [t, df, p] = statcond( {C1,C2}, 'method','perm','naccu',1000);
 end

significantMat(p<=alpha) = 1;
tsignificantMat = t .* significantMat;
tsignificantMat(logical(eye(size(tsignificantMat)))) = 0;
