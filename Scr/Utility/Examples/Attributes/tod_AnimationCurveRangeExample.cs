using System;
using UnityEngine;
using TimeOfDay.Utility;

namespace TimeOfDay.Utility.Examples
{
    public class TOD_AnimationCurveRangeExample : MonoBehaviour
    {
        [TOD_AnimationCurveRange(0.0f, 0.0f, 1.0f, 1.0f, 0)]
        public AnimationCurve curve =  AnimationCurve.Linear(0.0f, 0.0f, 1.0f, 1.0f);

        [SerializeField, TOD_AnimationCurveRange(0.0f, 0.0f, 5.0f, 2.0f, 1)]
        public AnimationCurve curve1 =  AnimationCurve.Linear(0.0f, 1.0f, 5.0f, 2.0f);
    }
}


