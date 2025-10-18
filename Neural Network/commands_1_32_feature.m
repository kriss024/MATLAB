%normalized score
[GenS_source,ForS_source]= scoresNormalization(dbAgeTwo,ones(1,32),ones(1,32));
%verification mdule - paramteres estimation
for FEATURE_NUMBER=1:2 % change to 32 feature

    GenS=GenS_source(1:end,FEATURE_NUMBER:FEATURE_NUMBER);
    ForS=ForS_source(1:end,FEATURE_NUMBER:FEATURE_NUMBER);

    best_EER=1;
    for i=1:10

          [Y,net,P,T,tr]=trainNN(GenS(1:30,:),ForS(1:120,:),20) ;%genuines scores, forgeries scores, numers of neurons in network
          %testing the results
          Yf = sim(net,ForS');
          Yg = sim(net,GenS');
          %errors calculation
          res=ac_eer(-Yg,-Yf);
          if res.EER<best_EER
             bestNet=net;
          end;
    end


    %performance for best net
    'performance for best net'
    Yf=0;
    Yg=0;
    %testing the results
    Yf = sim(bestNet,ForS');
    Yg = sim(bestNet,GenS');
    %errors calculation
    res=ac_eer(-Yg,-Yf);
    res

    %testing the results for a list of users
    'performance for selected uses'

    list=[1,2,5,9];
    %list=[1,2,3,4,5,6,7,8,9];
    Yf=[];
    Yg=[];
    %testing the results
    for u=1:size(list,2)
          idx=list(u);
          Yf = [Yf,sim(bestNet,ForS((idx-1)*20+1:(idx-1)*20+20,:)')];
          Yg = [Yg,sim(bestNet,GenS((idx-1)*5+1:(idx-1)*5+5,:)')];
    end
    %errors calculation
    res=ac_eer(-Yg,-Yf);
    res
    EER_Result_Vector(FEATURE_NUMBER)=res.EER;
end