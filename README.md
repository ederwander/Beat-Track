Beat per Minutes calculation
==========

Copyright 2012, Eng Eder de Souza

Matlab/Octave source for beat track calculation!

The approach used in this code are described by George Tzanetakis, 
the beat calculation is made breaking the signal in sub-band frequencies using DWT(Discrete wavelet transform),
After get all sub-bands we need envelope each band,
sum all Envelopes to a single onset strength signal and apply auto-correlation to find the peak position.

        Tempo Extraction Steps:
        
        
DWT(Discrete wavelet transform)
==========

Decompose the signal in six frequency bands (six level) using DWT

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/Wavelets_-_Filter_Bank.png)](#features)

Envelope extraction from sub-bands
==========

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/C_Envelope_follower.png)](#features)

*Envelope Calculation

Apply Full Wave Rectification

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/Full_Wave_Rectification.png)](#features)

Apply Low Pass Filter

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/Low_Pass_Filter.png)](#features)

Apply Downsample

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/Downsample.png)](#features)

Apply Mean Removal

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/Mean_Removal.png)](#features)

Apply Autocorrelation

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/Autocorrelation.png)](#features)

Finally find Beat per Minutes 

[![Beat-Track dualmode](https://github.com/ederwander/Beat-Track/raw/master/img/BPM.png)](#features)

Beat Examples in the folder [AudioTest] (https://github.com/ederwander/Beat-Track/tree/master/AudioTest)

How use:

        BPM=RunBPM('AudioTest/B128.wav')


Special thanks to George Tzanetakis who helped me at some points by email !

Eng Eder de Souza