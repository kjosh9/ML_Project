% Some environment variables
cifar10dir = './cifar10/';
datadir = './data/';
datafile = 'cifar10.mat';

% Check if data directory exists
if exist(datadir, 'dir') == 0
    mkdir(datadir);
end

% Compile the data
[data, labels] = compileCIFARData({[cifar10dir 'data_batch_1.mat'],...
    [cifar10dir 'data_batch_2.mat'],...
    [cifar10dir 'data_batch_3.mat'],...
    [cifar10dir 'data_batch_4.mat'],...
    [cifar10dir 'data_batch_5.mat']...
});

% Save the data
save([datadir datafile], 'data', 'labels');

% Destroy the evidence
clearvars data labels cifar10dir datadir datafile;