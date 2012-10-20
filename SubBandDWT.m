function [SubBand, numerator, denominator]=SubBandDWT(Signal,Fs,L,H)


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
% 
%   This file is part of Beat track source, based in the paper:
%   Tempo Extraction using Beat Histograms from George Tzanetakis
% 
%   This function use Discrete Wavelet Transform to Extract Sub-Bands
%   range from one input signal.
%   


%Normalize the Low Frequency Band
LowFrequencyBand = L/(Fs/2);

%Creating the highpass filter coefficient
[numerator,denominator] = butter(2, LowFrequencyBand, 'high');

%Apply highpass filter in the signal wave
FiltredSignal = filtfilt(numerator, denominator, Signal);

%Normalize the High Frequency Band
HighFrequencyBand = H/(Fs/2);

%Creating the lowpass filter coefficient
[numerator,denominator] = butter(2, HighFrequencyBand, 'low');

%Apply Lowpass filter in the FiltredSignal
SubBand = filtfilt(numerator, denominator, FiltredSignal);

