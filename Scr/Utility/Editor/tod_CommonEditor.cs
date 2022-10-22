using System;
using UnityEngine;
using UnityEditor;

namespace TimeOfDay.Utility
{
    public abstract class TOD_CommonEditor : Editor
    {

        // Set Obj.
        protected SerializedObject serObj;

        /// <summary> Title Styule. </summary>
        protected GUIStyle TextTitleStyle
        {
            get
            {
                GUIStyle s  = new GUIStyle(EditorStyles.label);
                s.fontStyle = FontStyle.Bold;
                s.fontSize  = 20;
                return s;
            }
        }

        /// <summary></summary>
        protected GUIStyle TextTabTitleStyle
        {
            get
            {
                GUIStyle s  = new GUIStyle(EditorStyles.label);
                s.fontStyle = FontStyle.Bold;
                s.fontSize  = 10;
                return s;
            }
        }

        /// <summary></summary>
        protected virtual string Title => "New Class";

      
        protected virtual void OnEnable()
        {
            serObj = new SerializedObject(target);
        }

        public override void OnInspectorGUI()
        {
            serObj.Update();

            TOD_EditorGUIUtility.ShurikenHeader(Title, TextTitleStyle, TOD_ShurikenStyle.TitleHeader);

            _OnInspectorGUI();

            serObj.ApplyModifiedProperties();

        }
        protected abstract void _OnInspectorGUI();
    }
}
