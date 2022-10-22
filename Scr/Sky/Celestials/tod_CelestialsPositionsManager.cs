
using System;
using UnityEngine;
using TimeOfDay.Utility;

namespace TimeOfDay
{
    [ExecuteInEditMode]
    [RequireComponent(typeof(TOD_Dome)), RequireComponent(typeof(TOD_DateTimeManager))]
    public class TOD_CelestialsPositionsManager : MonoBehaviour
    {
        [SerializeField] private TOD_Dome m_Dome = null;
        [SerializeField] private TOD_DateTimeManager m_DateTime = null;

        public TOD_PlanetaryPositions planetary = new TOD_PlanetaryPositions();

        /// <summary></summary>
        public bool IsDay
        {
            get{ return m_Dome.IsDay; }
        }

        /// <summary></summary>
        public Quaternion OuterSpaceRotation
        {
            get
            {
                return Quaternion.Euler(90 - planetary.Latitude, 0.0f, 0.0f) * 
                Quaternion.Euler(0.0f, planetary.Longitude, 0.0f) * 
                Quaternion.Euler(0.0f, planetary.LocalSideralTime * Mathf.Rad2Deg, 0.0f);
            }
        }

        void Awake()
        {
            m_Dome = GetComponent<TOD_Dome>();
            m_DateTime = GetComponent<TOD_DateTimeManager>();
        }

        void Update()
        {

            planetary.dateTime = m_DateTime.SystemDateTime;
            m_DateTime.OverrideDayState = true;
            m_DateTime.IsDay = IsDay;

            planetary.ComputeSunCoords();
            planetary.ComputeMoonCoords();

            m_Dome.SunAltitude  = planetary.SunAltitude;
            m_Dome.SunAzimuth   = planetary.SunAzimuth;

            m_Dome.MoonAltitude = planetary.MoonAltitude;
            m_Dome.MoonAzimuth  = planetary.MoonAzimuth;

            m_Dome.DeepSpaceRotation = OuterSpaceRotation;
        }

    }
}