using System;
using UnityEngine;

namespace TimeOfDay
{
    [RequireComponent(typeof(TOD_Dome)), ExecuteInEditMode]
    public class TOD_SkyManager : MonoBehaviour
    {
    #region [References]
        [SerializeField] private TOD_Dome m_Dome = null;
    #endregion

    #region [Elements]

        public TOD_AtmosphericScattering atmosphericScattering = new TOD_AtmosphericScattering();

        public TOD_DeepSpace deepSpace = new TOD_DeepSpace();

        public TOD_Sun sun = new TOD_Sun();
        public TOD_Moon moon = new TOD_Moon();

        public TOD_Clouds clouds = new TOD_Clouds();

    #endregion

    #region [Initialize]

        private void Awake()
        {
            m_Dome = GetComponent<TOD_Dome>();
        }

        private void Start()
        {
           // if(!m_Dome.IsReady) return;

            atmosphericScattering.Initialize();
        }

    #endregion

    #region [Update]

        private void Update()
        {
            if(!m_Dome.IsReady) return;

            atmosphericScattering.SunDir  = m_Dome.LocalSunDirection;
            atmosphericScattering.MoonDir = m_Dome.LocalMoonDirection;
            atmosphericScattering.SunEvaluteTime = m_Dome.EvaluateTimeBySun;
            atmosphericScattering.SetGlobalParams();

            if(atmosphericScattering.MoonRayleighMode == TOD_MoonRayleighMode.CelestialContribution)
                m_Dome.EnableMoonContribution = true;

            deepSpace.SetParams(m_Dome.Resources.deepSpaceMaterial, m_Dome.EvaluateTimeBySun);
            sun.SetParams(m_Dome.Resources.sunMaterial);
            moon.SetParams(m_Dome.Resources.moonMaterial);

            clouds.EnableMoonContribution = m_Dome.EnableMoonContribution;
            clouds.SunEvaluateTime = m_Dome.EvaluateTimeBySun;
            clouds.MoonEvaluateTime = m_Dome.EvaluateTimeByMoon;
            clouds.SetParams(m_Dome.Resources.cloudsMaterial);
        }

    #endregion
    }
}