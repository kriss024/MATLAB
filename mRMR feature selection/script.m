clear;
load('matlab.mat');
load('Users.mat');

signatures_1_20=1;
signatures_21_40=0;
% you put here database what you want analyze
DB_proc=DB;

[row,col]=size(DB_proc);
DB_of_feat=[];
signatures_category=[];

for m = 1:row
    for n = 1:20
        sign1=DB_proc(m,n);
        feats=feat(sign1.data,1);
        DB_of_feat=[DB_of_feat;feats];
        signatures_category=[signatures_category;signatures_1_20];
    end
    for n = 21:40
        sign1=DB_proc(m,n);
        feats=feat(sign1.data,1);
        DB_of_feat=[DB_of_feat;feats];
        signatures_category=[signatures_category;signatures_21_40];
    end
end

disp('Index of significant features:');
disp(mRMR(DB_of_feat,signatures_category,10)');