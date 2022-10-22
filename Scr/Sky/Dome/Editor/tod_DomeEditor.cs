/* 
using UnityEngine;
using UnityEditor;
using TimeOfDay.Utility;

namespace TimeOfDay
{

    // [CustomEditor(typeof(TOD_Dome))]
    public class TOD_DomeEditor : TOD_CommonEditor
    {

        // Target
        /////////////////////
        TOD_Dome tar;

        // General Settings.
        /////////////////////
        SerializedProperty m_GlobalIntensity;
        SerializedProperty m_SetGeneralParams;
        SerializedProperty m_DomeRadius;

        // Atmosphere.
        ////////////////////
        SerializedProperty m_RenderAtmosphere;
        SerializedProperty m_AtmosphereMeshQuality;


        protected override void _OnInspectorGUI(){}

    }
}*/