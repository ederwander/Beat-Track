function [RectifiedEnvelope]=Envelope(SubBand,DecimateValue,new_fs,numerator,denominator)


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
%   Envelope the Sub-Band signal using:
%	-Full Wave retification
%	-Low Pass Filter
%	-Downsample
%	-Mean Removal


%apply full Wave retification
SubBand = abs(SubBand);

%low pass filter
LowPassSubBand = filtfilt(numerator, denominator, SubBand);

%downsample
bands = downsample(LowPassSubBand, DecimateValue);

%apply mean removal
MeanRemoval=bands-mean(bands);


Tw = 0.1;
Nw=Tw*new_fs;
w=ones(Nw,1)/Nw;     


RectifiedEnvelope=conv((MeanRemoval),w,'same');

