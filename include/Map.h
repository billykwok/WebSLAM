#ifndef MAP_H
#define MAP_H

#include "KeyFrame.h"
#include "MapPoint.h"
#include <boost/serialization/base_object.hpp>
#include <mutex>
#include <set>

namespace WEB_SLAM {
  class MapPoint;
  class KeyFrame;
  class Atlas;
  class KeyFrameDatabase;

  class Map {
      friend class boost::serialization::access;

      template <class Archive>
      void serialize(Archive &ar, const unsigned int version) {
        ar &mnId;
        ar &mnInitKFid;
        ar &mnMaxKFid;
        ar &mnBigChangeIdx;

        // Save/load a set structure, the set structure is broken in
        // libboost 1.58 for ubuntu 16.04, a vector is serializated ar &
        // mspKeyFrames; ar & mspMapPoints;
        ar &mvpBackupKeyFrames;
        ar &mvpBackupMapPoints;

        ar &mvBackupKeyFrameOriginsId;

        ar &mnBackupKFinitialID;
        ar &mnBackupKFlowerID;

        ar &mbImuInitialized;
        ar &mbIsInertial;
        ar &mbIMU_BA1;
        ar &mbIMU_BA2;
      }

    public:
      EIGEN_MAKE_ALIGNED_OPERATOR_NEW
      Map();
      Map(int initKFid);
      ~Map();

      void AddKeyFrame(KeyFrame *pKF);
      void AddMapPoint(MapPoint *pMP);
      void EraseMapPoint(MapPoint *pMP);
      void EraseKeyFrame(KeyFrame *pKF);
      void SetReferenceMapPoints(const std::vector<MapPoint *> &vpMPs);
      void InformNewBigChange();
      int GetLastBigChangeIdx();

      std::vector<KeyFrame *> GetAllKeyFrames();
      std::vector<MapPoint *> GetAllMapPoints();
      std::vector<MapPoint *> GetReferenceMapPoints();

      long unsigned int MapPointsInMap();
      long unsigned KeyFramesInMap();

      long unsigned int GetId();

      long unsigned int GetInitKFid();
      void SetInitKFid(long unsigned int initKFif);
      long unsigned int GetMaxKFid();

      KeyFrame *GetOriginKF();

      void SetCurrentMap();
      void SetStoredMap();

      bool HasThumbnail();
      bool IsInUse();

      void SetBad();
      bool IsBad();

      void clear();

      int GetMapChangeIndex();
      void IncreaseChangeIndex();
      int GetLastMapChange();
      void SetLastMapChange(int currentChangeId);

      void SetImuInitialized();
      bool isImuInitialized();

      void ApplyScaledRotation(const Sophus::SE3f &T,
                               const float s,
                               const bool bScaledVel = false);

      void SetInertialSensor();
      bool IsInertial();
      void SetIniertialBA1();
      void SetIniertialBA2();
      bool GetIniertialBA1();
      bool GetIniertialBA2();

      void PrintEssentialGraph();
      bool CheckEssentialGraph();
      void ChangeId(long unsigned int nId);

      unsigned int GetLowerKFID();

      void PreSave(std::set<GeometricCamera *> &spCams);
      void PostLoad(
          KeyFrameDatabase *pKFDB,
          ORBVocabulary
              *pORBVoc /*, map<long unsigned int, KeyFrame*>& mpKeyFrameId*/,
          map<unsigned int, GeometricCamera *> &mpCams);

      void printReprojectionError(list<KeyFrame *> &lpLocalWindowKFs,
                                  KeyFrame *mpCurrentKF,
                                  string &name,
                                  string &name_folder);

      vector<KeyFrame *> mvpKeyFrameOrigins;
      vector<unsigned long int> mvBackupKeyFrameOriginsId;
      KeyFrame *mpFirstRegionKF;
      std::mutex mMutexMapUpdate;

      // This avoid that two points are created simultaneously in separate
      // threads (id conflict)
      std::mutex mMutexPointCreation;

      bool mbFail;

      // Size of the thumbnail (always in power of 2)
      static const int THUMB_WIDTH = 512;
      static const int THUMB_HEIGHT = 512;

      static long unsigned int nNextId;

      // DEBUG: show KFs which are used in LBA
      std::set<long unsigned int> msOptKFs;
      std::set<long unsigned int> msFixedKFs;

    protected:
      long unsigned int mnId;

      std::set<MapPoint *> mspMapPoints;
      std::set<KeyFrame *> mspKeyFrames;

      // Save/load, the set structure is broken in libboost 1.58 for
      // ubuntu 16.04, a vector is serializated
      std::vector<MapPoint *> mvpBackupMapPoints;
      std::vector<KeyFrame *> mvpBackupKeyFrames;

      KeyFrame *mpKFinitial;
      KeyFrame *mpKFlowerID;

      unsigned long int mnBackupKFinitialID;
      unsigned long int mnBackupKFlowerID;

      std::vector<MapPoint *> mvpReferenceMapPoints;

      bool mbImuInitialized;

      int mnMapChange;
      int mnMapChangeNotified;

      long unsigned int mnInitKFid;
      long unsigned int mnMaxKFid;
      // long unsigned int mnLastLoopKFid;

      // Index related to a big change in the map (loop closure, global BA)
      int mnBigChangeIdx;

      // View of the map in aerial sight (for the AtlasViewer)
      GLubyte *mThumbnail;

      bool mIsInUse;
      bool mHasTumbnail;
      bool mbBad = false;

      bool mbIsInertial;
      bool mbIMU_BA1;
      bool mbIMU_BA2;

      // Mutex
      std::mutex mMutexMap;
  };
} // namespace WEB_SLAM

#endif // MAP_H
