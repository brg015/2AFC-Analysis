clear;clc;

tempdata = {'S20130903a_REX';
    'S20130910a_REX';
    'S20130912a_REX';
    'S20130913a_REX';
    'S20130917a_REX';
    'S20130919a_REX';
    'S20130920a_REX';
    'S20130924a_REX';
    'S20130926a_REX';
    'S20130927a_REX';
    'S20131001a_REX';
    'S20131003a_REX';
    'S20131004c_REX';
    'S20131008a_REX';
    'S20131010a_REX';
    'S20131010b_REX';
    'S20131014a_REX';
    'S20131016a_REX';
    'S20131017a_REX';
    'S24R3A0_1222_REX';
    'S24R3A0_1223_REX';
    };

for n = 1:length(tempdata);
    [truncodes, truntimes] = findcompleted(char(tempdata(n)));
    out(n,1) = n;
    out(n,2) = getrulebias(truncodes);
    out(n,3) = getsidebias(truncodes);
    out(n,4) = getsidebias_cont(truncodes);
end
