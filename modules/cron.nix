{ config, pkgs, inputs, ... }:
{
    services.cron = {
        enable = true;
        systemCronJobs = [
            "* */3 * * *    root    gwern-to-rss > /home/abyss/Public/gwern.xml"
        ];
    };
}

