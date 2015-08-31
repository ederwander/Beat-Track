function [BPM]=RunBPM(AudioFile)


%   Copyright (c) 2012 Eder de Souza.
%
%   This program is free software; you can redistribute it and/or modify        
%   it under the terms of the GNU General Public License as published by        
%   the Free Software Foundation; either version 2 of the License, or           
%   (at your option) any later version.                                         
%                                                                                
%   This program is distributed in the hope that it will be useful,             
%   but WITHOUT ANY WARRANTY; without even the implied warranty of              
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               
%   GNU General Public License for more details.                                
%                                                                                
%   You should have received a copy of the GNU General Public License           
%   along with this program; if not, write to the Free Software                 
%   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  
% 
% ---------------------------------------------------------------------------------------------------------------------
%
%   The approach used in this code are described by George Tzanetakis,
%   The beat calculation is made breaking the signal in sub-band frequencies using DWT(Discrete wavelet transform),
%   After get all sub-bands we need envelope each band,
%   sum all Envelopes to a single onset strength signal and apply auto-correlation to find the peak position. 
%   
%
%How use:
%
%BPM=RunBPM('AudioTest/B128.wav')

[Signal,Fs]=wavread(AudioFile);


%Search BPM between 40 and 200
MinBPM=40;
MaxBPM=200;

new_fs = 22050;
EnvelopeDecimated=250;


%Calc all sub-bands applying DWT(Discrete wavelet transform)
%Using six frequency bands "Scheirer" (200, 400, 800, 1600, 3200, 6400)

[SubBand1, numerator1, denominator1]=SubBandDWT(Signal,Fs,1,200);

[SubBand2, numerator2, denominator2]=SubBandDWT(Signal,Fs,200,400);

[SubBand3, numerator3, denominator3]=SubBandDWT(Signal,Fs,400,800);

[SubBand4, numerator4, denominator4]=SubBandDWT(Signal,Fs,800,1600);

[SubBand5, numerator5, denominator5]=SubBandDWT(Signal,Fs,1600,3200);

[SubBand6, numerator6, denominator6]=SubBandDWT(Signal,Fs,3200,6400);


DecimateValue = ceil(Fs/new_fs);



%Constructing all envelopes one from each sub-band

Envelope1=Envelope(SubBand1, DecimateValue, new_fs, numerator1, denominator1);

Envelope2=Envelope(SubBand2, DecimateValue, new_fs, numerator2, denominator2);

Envelope3=Envelope(SubBand3, DecimateValue, new_fs, numerator3, denominator3);

Envelope4=Envelope(SubBand4, DecimateValue, new_fs, numerator4, denominator4);

Envelope5=Envelope(SubBand5, DecimateValue, new_fs, numerator5, denominator5);

Envelope6=Envelope(SubBand6, DecimateValue, new_fs, numerator6, denominator6);


%reduce around 2500 points (equivalent envelope decimate to 250Hz) to increase performance of the auto-correlation algorithm

EnvelopeDecimated1=Envelope1(1:floor((Fs/DecimateValue)/EnvelopeDecimated):length(Envelope1));
EnvelopeDecimated2=Envelope2(1:floor((Fs/DecimateValue)/EnvelopeDecimated):length(Envelope2));
EnvelopeDecimated3=Envelope3(1:floor((Fs/DecimateValue)/EnvelopeDecimated):length(Envelope3));
EnvelopeDecimated4=Envelope4(1:floor((Fs/DecimateValue)/EnvelopeDecimated):length(Envelope4));
EnvelopeDecimated5=Envelope5(1:floor((Fs/DecimateValue)/EnvelopeDecimated):length(Envelope5));
EnvelopeDecimated6=Envelope5(1:floor((Fs/DecimateValue)/EnvelopeDecimated):length(Envelope6));

%sum all envelopes
SumEnvelope = EnvelopeDecimated1 + EnvelopeDecimated2 + EnvelopeDecimated3 + EnvelopeDecimated4 + EnvelopeDecimated5 + EnvelopeDecimated6;


%apply auto correlation on Envelope
CorrelationEnvelope=AutoCorrelation(SumEnvelope,EnvelopeDecimated,MinBPM,MaxBPM);

%get the peak position from auto correlation result
[max_strength, max_pos]=max(CorrelationEnvelope);

%Get the BPM 
BPM=60*EnvelopeDecimated/(max_pos);
