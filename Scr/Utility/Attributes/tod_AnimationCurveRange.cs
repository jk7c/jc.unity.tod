using System;
using UnityEngine;

namespace TimeOfDay.Utility
{
    /// <summary> Range values for animation curves </summary>
    public class TOD_AnimationCurveRange : PropertyAttribute
    {
    #region [Ranges]
        public readonly float timeStart;
        public readonly float valueStart;
        public readonly float timeEnd;
        public readonly float valueEnd;
    #endregion
    
    #region [Settings]
        public readonly int colorIndex;
    #endregion

        public TOD_AnimationCurveRange(float _timeStart, float _valueStart, float _timeEnd, float _valueEnd, int _colorIndex)
        {
            this.timeStart  = _timeStart;
            this.valueStart = _valueStart;
            this.timeEnd    = _timeEnd;
            this.valueEnd   = _valueEnd;
            this.colorIndex = _colorIndex;
        }

    }

}

