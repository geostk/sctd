load('BaseParams.mat')

time = 0:1:128;
dictfn = @(numModes) SinCosWindowedDictEven(numModes, time);
dataname = 'Figure4DataNoiseless.mat';

noisefn = @(X) X;

numTrials = 1;
errors = zeros(numTrials, 1);
corrs = zeros(numTrials, 1);
sparsities = zeros(numTrials, 1);


numModes = 100;
for j = 46:75
    expnum = sprintf('A%d',j);
    
    for t = 1:numTrials
        [errors(t), corrs(t), sparsities(t)] = BaseExperiment(decompfn, dictfn, dataname, initfnA, ...
        initfnB, initfnZ, noisefn, numModes, Zthresholdfn, max_iter, lowtau, ...
        hightau, perturbAfn, perturbBfn, perturbZfn, expnum, t, ...
        lenSqn, slopeThreshold, diffThreshold);
    end

    csvwrite(sprintf('./exp%s/summary.csv',expnum),[errors, corrs, sparsities])
    numModes = numModes + 100; % 100 -> 3000
end