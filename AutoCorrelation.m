function [Xcorre]=AutoCorrelation(ENVELOPE,EnvelopeDecimated,MinBPM,MaxBPM)



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
%   Apply Auto Correlation in envelope signal.


%Auto Correlation Calc


EndPosition = ceil((60 * EnvelopeDecimated) / (MinBPM));

StartPosition = ceil((60 * EnvelopeDecimated) / (MaxBPM));

TotalSamples = length(ENVELOPE) - EndPosition;

Xcorre = zeros(EndPosition,1);

for pos=StartPosition:EndPosition,
	sum = 0;
	for i=1:TotalSamples,
		sum = sum + (ENVELOPE(i)*ENVELOPE(i + pos));
	end
	Xcorre(pos) = Xcorre(pos) + sum;
end




