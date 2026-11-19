import { Config } from '@remotion/cli/config';

Config.setVideoImageFormat('png');
Config.setOverwriteOutput(true);
Config.setConcurrency(4);
Config.setChromiumOpenGlRenderer('angle');
// Browser path is resolved from the studio's cached runtime on the target host.
// Set REMOTION_BROWSER_EXECUTABLE to an absolute allowlisted path when rendering offline.
if (process.env.REMOTION_BROWSER_EXECUTABLE) {
  Config.setBrowserExecutable(process.env.REMOTION_BROWSER_EXECUTABLE);
}
