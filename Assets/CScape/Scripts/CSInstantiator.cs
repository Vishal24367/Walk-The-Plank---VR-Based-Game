//#if UNITY_EDITOR
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using CScape;
//using UnityEditor;
//using UnityEditor.SceneManagement;
using UnityEngine.SceneManagement;
using System.Linq;
//using UnityEditor;

namespace CScape
{
    [RequireComponent(typeof(MeshFilter))]
    [RequireComponent(typeof(MeshRenderer))]

    public class CSInstantiator : MonoBehaviour
    {


        public int instancesX;
        public int instancesZ;
        public Material mat;
        public Mesh mesh;
        public Mesh meshOriginal;
        public GameObject originalObject;
        public int offsetX;
        public int offsetZ;
        public bool update;
        public int width;
        public int depth;
        public int maxMeshSize;
        public StreetModifier parentSection;
        public LODGroup lodGroup;
        bool isPrefabOriginal;
        public bool useSkewing = false;
        public float skewAngleFront;
        public float skewAngleBack;
        public float skewAngleLeft;
        public float skewAngleRight;
        public float baseOffset = 0.5f;
        public int slitFront;
        public int slitBack;
        public int slitLeft;
        public int slitRight;
        public GameObject streetParent;

        // Use this for initialization
        public void AwakeMe()
        {
            lodGroup = GetComponent<LODGroup>();
            UpdateElements();
        }

        // Update is called once per frame

        public void UpdateElements()
        {
#if UNITY_EDITOR
            isPrefabOriginal = UnityEditor.PrefabUtility.GetPrefabParent(gameObject) == null && UnityEditor.PrefabUtility.GetPrefabObject(gameObject.transform) != null;
#endif
            if (!isPrefabOriginal)
            {
                if (streetParent)
                {
                    StreetModifier sm = streetParent.GetComponent<StreetModifier>();
                    if (sm) { 
                        slitFront = sm.slitRB;
                        slitBack = sm.slitLF;
                    }

                }
                else
                {
                    skewAngleFront = 0;
                    skewAngleBack = 180;
                    skewAngleRight = -90;
                    skewAngleLeft = 90;

                }

                instancesX = ((depth - 1) * 3 / offsetX);
                instancesZ = ((width - 1) * 3 / offsetZ);
                DeleteSolution();

                maxMeshSize = Mathf.CeilToInt(65000f / (originalObject.GetComponent<MeshFilter>().sharedMesh.vertices.Length * 2));
                //Debug.Log(maxMeshSize + ", " + originalObject.GetComponent<MeshFilter>().sharedMesh.vertices.Length);

                if (instancesX > maxMeshSize) instancesX = maxMeshSize;
                if (instancesX < 1) instancesX = 1;
                
                Vector3 baseOffset2 = new Vector3(0.5f, 0, -0.5f);
                Vector3 baseOffsetSymetry = new Vector3(0.5f, 0, -0.5f);
              

                    for (int j = 0; j < instancesX - 1; j++)
                    {
                        GameObject newObject = Instantiate(originalObject) as GameObject;
                        // newObject.GetComponent<MeshFilter>().mesh = meshOriginal;
                        newObject.transform.localPosition = new Vector3(baseOffset + 3, 0, baseOffset);
                        newObject.transform.Rotate(new Vector3(0, 0, skewAngleFront));
                        newObject.transform.Translate(new Vector3(j * offsetX, 0, 0));
                        newObject.transform.parent = gameObject.transform;
                        newObject.transform.Rotate(new Vector3(0, 0, 180));
                    }

                for (int j = 0; j < instancesX - 1; j++)
                {
                    GameObject newObject = Instantiate(originalObject) as GameObject;
                    // newObject.GetComponent<MeshFilter>().mesh = meshOriginal;
                    newObject.transform.localPosition = new Vector3(baseOffset + 3, 0, baseOffset + width * 3 - baseOffset * 2);
                    newObject.transform.Rotate(new Vector3(0, 0, skewAngleBack));
                    newObject.transform.Translate(new Vector3(j * -offsetX, 0, 0));
                    newObject.transform.parent = gameObject.transform;
                    newObject.transform.Rotate(new Vector3(0, 0, 180));
                }

                for (int j = 0; j < instancesZ - 1; j++)
                {
                    GameObject newObject = Instantiate(originalObject) as GameObject;
                    // newObject.GetComponent<MeshFilter>().mesh = meshOriginal;
                    newObject.transform.localPosition = new Vector3(-baseOffset + depth * 3, 0, baseOffset + 3);
                    newObject.transform.Rotate(new Vector3(0, 0, skewAngleRight));
                    newObject.transform.Translate(new Vector3(j * offsetZ, 0, 0));
                    newObject.transform.parent = gameObject.transform;
                    newObject.transform.Rotate(new Vector3(0, 0, 180));
                }

                for (int j = 0; j < instancesZ - 1; j++)
                {
                    GameObject newObject = Instantiate(originalObject) as GameObject;
                    // newObject.GetComponent<MeshFilter>().mesh = meshOriginal;
                    newObject.transform.localPosition = new Vector3(baseOffset , 0, baseOffset - 3 + width * 3 - baseOffset * 2);
                    newObject.transform.Rotate(new Vector3(0, 0, skewAngleLeft));
                    newObject.transform.Translate(new Vector3(j * offsetZ, 0, 0));
                    newObject.transform.parent = gameObject.transform;
                    newObject.transform.Rotate(new Vector3(0, 0, 180));
                }




                MergeMeshes();

                // MeshCollider colliderMesh = GetComponent(typeof(MeshCollider)) as MeshCollider;



                //mesh.vertices = vertices;
                //mesh.colors = vColors;
                //mesh.uv = uV;
                //mesh.RecalculateBounds();

            }
        }

        public void MergeMeshes()
        {

            MeshFilter[] meshFilters = GetComponentsInChildren<MeshFilter>();
            CombineInstance[] combine = new CombineInstance[meshFilters.Length - 1];

            int index = 0;
            for (int i = 0; i < meshFilters.Length; i++)
            {
                if (meshFilters[i].sharedMesh != null)
                {
                    // if (meshFilters[i].sharedMesh == null) continue;
                    combine[index].mesh = meshFilters[i].sharedMesh;
                    combine[index++].transform = meshFilters[i].transform.localToWorldMatrix;
                }
            }
            MeshFilter meshF = transform.GetComponent<MeshFilter>();
            meshF.sharedMesh = new Mesh();
            meshF.sharedMesh.name = "lightpoles";
            meshF.sharedMesh.CombineMeshes(combine);
            meshF.sharedMesh.RecalculateBounds();
            if (lodGroup != null) lodGroup.RecalculateBounds();

            //    transform.gameObject.SetActive(true);
            foreach (Transform go in gameObject.transform.Cast<Transform>().Reverse())
            {
                DestroyImmediate(go.gameObject);
            }

            MeshCollider mColl = gameObject.GetComponent<MeshCollider>();
            mColl.sharedMesh = meshF.sharedMesh;
        }

        public void DeleteSolution()
        {

            foreach (Transform go in gameObject.transform.Cast<Transform>().Reverse())
            {
                DestroyImmediate(go.gameObject);
            }
            DestroyImmediate(transform.GetComponent<MeshFilter>().sharedMesh);
        }
    }
}
//#endif