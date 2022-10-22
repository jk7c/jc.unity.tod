using System;
using UnityEngine;

namespace TimeOfDay
{
    [Serializable] public class TOD_FogParams
    {

        public FogMode fogMode;

        // Density.
        public float density;
        public float startDistance, endDistance;

        // Depth.
        [Range(0.0f, 1.0f)]
        public float rayleighDepthMultiplier;
        public float sunMiePhaseDepthMultiplier;
        public float moonMieṔhaseDepthMultiplier;

        // Color.

        [Range(0.0f, 1.0f)]
        public float smoothTint, blendTint;
    }

}