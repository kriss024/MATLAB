function[GenS,ForS]= scoresNormalization(DB,features_normalization,features_selection)

GenS=[];
ForS=[];
% number of classes/users
[m,n] = size(DB);
MAX_USERS = m;
%numer of enrollment signatures
MAX_GENUINE_TOKENS = 15;

% template creation - mean values in enrolment set for each feature
disp('Template creation in acction');
for u=1:MAX_USERS
    

       for t=1:MAX_GENUINE_TOKENS
                      
                % calculate features
                T1 = feat(DB(u,t).data,1);
                


   %          features_normalization.*features_selection
                T(t,:) = T1.*(features_normalization.*features_selection);
       end
      
    TEMP(u,:)=mean(T);
    STD(u,:)=std(T);
end


%genuine signature werification
for u=1:MAX_USERS

        R=[];
       for t=6:10
                    T1 = feat(DB(u,t).data,1);   
                  %          features_normalization.*features_selection
                    V = T1.*(features_normalization.*features_selection);
TEMP(u,:)-V
                    R=[R; (TEMP(u,:)-V)./STD(u,:)];
       end
      GenS=[GenS;R];

end
%skilled forgeries verification
for u=1:MAX_USERS

        R=[];
       for t=1:20
                    T1 = feat(DB(u,t+20).data,1);   
                  %          features_normalization.*features_selection
                    V = T1.*(features_normalization.*features_selection);

                   R=[R; (TEMP(u,:)-V)./STD(u,:)];
       end
      ForS=[ForS;R];

end
