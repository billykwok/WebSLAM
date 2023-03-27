#ifndef ORBVOCABULARY_H
#define ORBVOCABULARY_H

#include "libs/DBoW2/DBoW2/FORB.h"
#include "libs/DBoW2/DBoW2/TemplatedVocabulary.h"

namespace WEB_SLAM {
  typedef DBoW2::TemplatedVocabulary<DBoW2::FORB::TDescriptor, DBoW2::FORB>
      ORBVocabulary;
} // namespace WEB_SLAM

#endif // ORBVOCABULARY_H
