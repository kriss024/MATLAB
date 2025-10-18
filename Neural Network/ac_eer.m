%AC_EER   Sample equal error rate calculation routine.
%  
%  [RES,DIST] = AC_EER(GEN,IMP)
% 
%  Input:
%  GEN - vector containing genuine scores
%  IMP - vector containing impostor scores
%
%  
%  Output:
%  DIST structure:
%   dxFRR (dxFAR) - abscisae of the sample FRR (FAR) cumulative distribution
%   dyFRR (dyFAR) - ordinates of the sample FRR (FAR) cumulative
%   distribution
%
%  RES structure:
%   OPTFAR        - sample FAR obtained for optimal acceptance threshold THR
%   OPTFRR        - sample FRR obtained for optimal acceptance threshold THR
%   EER           - estimation of EER based on OPTFAR and OPTFRR (may represent the EER not achieve)
%   SEP           - SEP = max(GEN)-min(IMP)
%   THR           - acceptance threshold set to achieve minimal OPTFAR and OPTFRR simultaneously 
%                   (the obtained score is LESS OR EQUAL to the threshold)
%   ZeroFAR       - the value of FRR for FAR = 0
%   ZeroFRR       - the value of FAR for FRR = 0
%
%  Function estimates equal error interval based on FAR and FRR estimators and given the sample scores. 
%  Both GEN and IMP must represent the distances, i.e., the lower the score the better the match. 
%  There is no need to keep equal lengths of GEN and IMP or to narrow GEN or IMP to a particular range. 
%  There is no need also to make GEN and IMP equidistantly sampled vs. threshold parameter. 
%  GEN and IMP may also contain multiple scores, and they must be vectors.
% 
%  Function uses FAR and FRR zero order estimators, GetFARAt and GetFRRAt,
%  respectively. They may be changed to support higher order estimators, if
%  required.
%  
%  __________________________________________________________________
%  (c) Adam Czajka, a.czajka@ia.pw.edu.pl
%  14.04.2009

function [RES DIST] = AC_EER(GEN,IMP);

[rows cols] = size(GEN);
if (rows~=1 & cols~=1)
    error('''GEN'' argument must be a vector');
end
if (rows > cols) 
    GEN = GEN.';
end

[rows cols] = size(IMP);
if (rows~=1 & cols~=1)
    error('''IMP'' argument must be a vector');
end
if (rows > cols) 
    IMP = IMP.';
end


%% approximation of the FA error function ...

x = sort(IMP,'ascend');
y = 1/length(IMP):1/length(IMP):1;

% remove duplicated results, yet keeping the cumulative
% density function correct
ytemp = find([diff(x)]);
DIST.dyFAR = [y(ytemp) 1];
DIST.dxFAR = x([ytemp length(IMP)]);


%% approximation of the FR error function ...

clear x y dx
x(1) = 1;
x = sort(GEN,'descend');
y = 1/length(GEN):1/length(GEN):1;

% remove duplicated results, yet keeping the cumulative
% density function correct
ytemp = find([diff(x)]);
DIST.dyFRR = [0 y(ytemp)];
DIST.dxFRR = x([ytemp length(GEN)]);


%% simplest cases
SIMPLEST = 0;
RES.sep = min(DIST.dxFAR) - max(DIST.dxFRR);
if (RES.sep > 0)
    RES.OptFAR = 0;
    RES.ZeroFAR = RES.OptFAR;
    RES.OptFRR = 0;
    RES.ZeroFRR = RES.OptFRR;
    RES.EER = (RES.OptFAR + RES.OptFRR)/2;
    RES.THR = mean([min(DIST.dxFAR) max(DIST.dxFRR)]);
    SIMPLEST = 1;
end

if (max(DIST.dxFAR) < min(DIST.dxFRR))
    RES.OptFAR = 1;
    RES.ZeroFAR = RES.OptFAR;
    RES.OptFRR = 1;
    RES.ZeroFRR = RES.OptFRR;
    RES.EER = (RES.OptFAR + RES.OptFRR)/2;
    RES.THR = min(DIST.dxFAR);
    SIMPLEST = 1;
end


%% typical case
if (SIMPLEST == 0)

%% calculation of the EER and the optimal threshold

%% Golden search routine
% rough EER point estimation for speed up based on Golden Search
% routine
iMaxIter = length(DIST.dxFRR) + length(DIST.dxFAR);
iEps = (max([max(GEN) max(IMP)])-min([min(GEN) min(IMP)]))/(2*(length(GEN)+length(IMP)));
disp('Golden Search routine:');
disp(['-- abscisa EPS automatically set to ' num2str(iEps)])

maxxFRR = max(DIST.dxFRR);
minxFAR = min(DIST.dxFAR);
minmin = min([minxFAR min(DIST.dxFRR)]);
maxmax = max([maxxFRR max(DIST.dxFAR)]);

TR = [minmin mean([minmin maxmax]) maxmax];
C = 0.38197;
fBestF = 1.0;

% tolerance for bracketing interval (minimum interval)
bStop = 0;
iIter = 0;
iIter2 = 0;

while (bStop == 0)
    if ( (TR(2)-TR(1)) > (TR(3)-TR(2)) )

        % divide the first segment
        % ---a-----x-----b-----c---
        % TR[1]       TR[2] TR[3]

        x = C*(TR(2)-TR(1))+TR(1);

        % goal function 2 calls per iteration
        FAR_ = GetFARAt(DIST,x);
        FRR_ = GetFRRAt(DIST,x);
        fCurrent = (FAR_-FRR_)^2;

        temp = TR(2);
        FAR_ = GetFARAt(DIST,temp);
        FRR_ = GetFRRAt(DIST,temp);
        fMiddle = (FAR_-FRR_)^2;

        % make division decision
        if (fCurrent < fMiddle)
            TR(3) = TR(2);
            TR(2) = x;
        else
            TR(1) = x;
        end

    else % if (w>0.5)
        % divide the second segment
        % ---a-----b-----x-----c---
        % TR(1] TR(2]       TR(3]

        x = C*(TR(3)-TR(2))+TR(2);

        % goal function 2 calls per iteration
        FAR_ = GetFARAt(DIST,x);
        FRR_ = GetFRRAt(DIST,x);
        fCurrent = (FAR_-FRR_)^2;

        temp = TR(2);
        FAR_ = GetFARAt(DIST,temp);
        FRR_ = GetFRRAt(DIST,temp);
        fMiddle = (FAR_-FRR_)^2;

        if (fCurrent < fMiddle)
            TR(1) = TR(2);
            TR(2) = x;
        else
            TR(3) = x;
        end
    end

    fMinCurrent = min([fCurrent fMiddle]);
    if (fMinCurrent < fBestF)
        fBestF = fMinCurrent;
        RES.THR = TR(2);
    end

    iEpsCurrent = min([abs(TR(3)-TR(1)) abs(TR(3)-TR(2))]);

    if ( (iEpsCurrent < iEps) || (iIter==iMaxIter) )
        bStop = 1;
    end
    
    iIter = iIter + 1; 
end

RES.OPTFAR = GetFARAt(DIST,RES.THR);
RES.OPTFRR = GetFRRAt(DIST,RES.THR);
RES.EER = mean([RES.OPTFAR RES.OPTFRR]);

disp(['-- iter=' num2str(iIter) ', abscisa EPS=' num2str(iEpsCurrent), ' (reached), |FAR-FRR|=' num2str(abs(RES.OPTFAR-RES.OPTFRR)) ', EER=' num2str(RES.EER) ', THR=' num2str(RES.THR)]);

%% Full inspection routine (may furter support Golden Search)
% rough EER point has been found
% let's launch the full inspection for -FI -> +FI cases to correct the
% EER point

% number of single threshold points in left and right directions to analyze
% EER thoroughly;
FI = 200;

% start point
ALL_SORTED = sort([DIST.dxFRR(:).' DIST.dxFAR(:).'],'descend');
ALL_SORTED_IND = find(ALL_SORTED < RES.THR);
thrToTakeStart = ALL_SORTED(ALL_SORTED_IND(min(FI,length(ALL_SORTED_IND))));

% stop point
ALL_SORTED = sort([DIST.dxFRR(:).' DIST.dxFAR(:).'],'ascend');
ALL_SORTED_IND = find(ALL_SORTED > RES.THR);
thrToTakeStop = ALL_SORTED(ALL_SORTED_IND(min(FI,length(ALL_SORTED_IND))));

ALL_SORTED = ALL_SORTED(find( (ALL_SORTED >= thrToTakeStart) & (ALL_SORTED <= thrToTakeStop) ));
FIChanged = 0;
for i=1:length(ALL_SORTED)
    FAR_ = GetFARAt(DIST,ALL_SORTED(i)+eps);
    FRR_ = GetFRRAt(DIST,ALL_SORTED(i)+eps);

    if (abs(RES.OPTFAR - RES.OPTFRR) > abs(FAR_-FRR_)) 
        FIChanged = 1;
        RES.OPTFAR = GetFARAt(DIST,ALL_SORTED(i)+eps);
        RES.OPTFRR = GetFRRAt(DIST,ALL_SORTED(i)+eps);
        RES.EER = mean([RES.OPTFAR RES.OPTFRR]);
        RES.THR = ALL_SORTED(i)+eps;
        break
    end
end

if (FIChanged)
    disp(['Full inspection routine: |FAR-FRR|=' num2str(abs(RES.OPTFAR-RES.OPTFRR)) ', EER=' num2str(RES.EER) ', THR=' num2str(RES.THR)]);
else
    disp('Full inspection routine: no better solution found.');
end


%% calculation of the ZeroFAR
RES.ZeroFRR = GetFARAt(DIST,max(DIST.dxFRR));


%% calculation of the ZeroFRR
RES.ZeroFAR = GetFRRAt(DIST,min(DIST.dxFAR));

end % if (SIMPLEST == 0)

%% Get sample FRR (based on zero-order approximation) at a given (real) point
function FRR = GetFRRAt(DIST,thr)

temp = [];
temp = find(DIST.dxFRR <= thr);
if (isempty(temp))
    FRR = 1.0;
else
    FRR = DIST.dyFRR(temp(1));
end

% i = 1;
% while ( (thr <= DIST.dxFRR(i)) & (i < length(DIST.dxFRR)) )
%     i = i + 1;
% end
% 
% if (thr <= DIST.dxFRR(i)) % still ...
%     FRR = 1.0;
% else
%     FRR = DIST.dyFRR(i);
% end


%% Get sample FAR (based on zero-order approximation) at a given (real) point
function FAR = GetFARAt(DIST,thr)

temp = [];
temp = find(DIST.dxFAR <= thr);
if (isempty(temp))
    FAR = 0.0;
else
    FAR = DIST.dyFAR(temp(end));
end

% i = 1;
% while ( (thr >= DIST.dxFAR(i)) & (i < length(DIST.dxFAR)) )
%     i = i + 1;
% end
% 
% if (thr >= DIST.dxFAR(i)) % still ...
%     FAR = 1.0;
% elseif (i>1)
%     FAR = DIST.dyFAR(i-1);
% else
%     FAR = 0.0;
% end