% Usage:
%   z_periodogram(data,srate,chan,nfig,color)
%       - default values:
%           color = 'k'
%           nfig  = 200
%           chan  = 1
%       - chan must be a scalar
%       - if chan = 0, display all channels
function z_periodogram(data,srate,chan,nfig,color)
    if nargin<5; color='k'; end
    if nargin<4; nfig =200; end
    if nargin<3; chan =1; end

    figure(nfig);
    hold on;
%         chan=19;
%         color='b';
        if chan==0
            for i=1:size(data,1)
                [y,x]=periodogram(data(i,:),[],'onesided',srate,srate);
                plot(x,y,'Color',color)
            end
        else
            [y,x]=periodogram(data(chan,:),[],'onesided',srate,srate);
            plot(x,y,'Color',color)
        end
        set(gcf,'Color','w');
        set(gca,'YScale','log',...
                'YGrid','on',...
                'XGrid','on',...
                'box','on');
        yticks=get(gca,'YTick');
        yticksdb=10*log10(yticks);
        set(gca,'YTickLabel',yticksdb);
%         set(gca,'YTickLabel',pow2db(yticks));
        xlabel('Frequency (Hz)');
        ylabel('Power/frequency (dB/Hz)');
        title('Periodogram Power Spectral Density Estimate');
end