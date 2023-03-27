#ifndef CONFIG_H
#define CONFIG_H

#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <unistd.h>

namespace WEB_SLAM {
  class ViewerConfig {};

  class CameraConfig {};

  class ORBExtractorConfig {};

  class IMUConfig {};

  class ConfigParser {
    public:
      bool ParseConfigFile(std::string &strConfigFile);

    private:
      ViewerConfig mViewerConfig;
      CameraConfig mCameraConfig;
      ORBExtractorConfig mORBConfig;
      IMUConfig mIMUConfig;
  };

} // namespace WEB_SLAM

#endif // CONFIG_H
