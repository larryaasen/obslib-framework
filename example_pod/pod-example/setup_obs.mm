//
//  setup_obs.mm
//  rtmpTest
//
//  Created by Larry Aasen on 3/7/21.
//

#import <AVFoundation/AVFoundation.h>

#include <stdio.h>
#include <time.h>

#include <functional>
#include <memory>

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import <OpenGL/OpenGL.h>

#include "obslib/obs.h"
#include "obslib/obs.hpp"
#include "obslib/obs-service.h"
#include "obslib/obs-output.h"
#include "obslib/obs-properties.h"

static const int cx = 1280;
static const int cy = 720;

template<typename T, typename D_T, D_T D>
struct OBSUniqueHandle : std::unique_ptr<T, std::function<D_T>> {
    using base = std::unique_ptr<T, std::function<D_T>>;
    explicit OBSUniqueHandle(T *obj = nullptr) : base(obj, D) {}
    operator T *() { return base::get(); }
};

#define DECLARE_DELETER(x) decltype(x), x

using SourceContext =
    OBSUniqueHandle<obs_source, DECLARE_DELETER(obs_source_release)>;

using SceneContext =
    OBSUniqueHandle<obs_scene, DECLARE_DELETER(obs_scene_release)>;

using DisplayContext =
    OBSUniqueHandle<obs_display, DECLARE_DELETER(obs_display_destroy)>;

#undef DECLARE_DELETER

extern "C" bool CreateOBS(void)
{
    if (!obs_startup("en", NULL, NULL)) {
        printf("Couldn't create OBS\n");
        return false; //throw "Couldn't create OBS";
    }

    struct obs_video_info ovi;
    ovi.adapter = 0;
    ovi.fps_num = 30000;
    ovi.fps_den = 1001;
    ovi.graphics_module = "libobs-opengl"; //DL_OPENGL
    ovi.output_format = VIDEO_FORMAT_RGBA;
    ovi.base_width = cx;
    ovi.base_height = cy;
    ovi.output_width = cx;
    ovi.output_height = cy;

    int rv = obs_reset_video(&ovi);
    if (rv != OBS_VIDEO_SUCCESS) {
        printf("Couldn't initialize video: %d\n", rv);
        return false; //throw "Couldn't initialize video";
    }
    
    struct obs_audio_info ai;
    ai.samples_per_sec = 48000;
    ai.speakers = SPEAKERS_STEREO;
    if (!obs_reset_audio(&ai)) {
        printf("Couldn't initialize audio\n");
        return false;
    }
    
    obs_load_all_modules();
    obs_post_load_modules();
    return true;
}
