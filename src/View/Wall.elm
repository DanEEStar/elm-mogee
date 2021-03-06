module View.Wall exposing (render)

import Math.Vector2 as Vec2 exposing (Vec2, vec2)
import Math.Vector3 as Vec3 exposing (Vec3)
import View.Common exposing (box, texturedFragmentShader, cropMask)
import WebGL exposing (Texture, Shader, Mesh, Entity)
import WebGL.Texture as Texture
import Components.Transform as Transform exposing (Transform)
import WebGL.Settings.DepthTest as DepthTest


type alias UniformTextured =
    { size : Vec2
    , offset : Vec3
    , texture : Texture
    , textureSize : Vec2
    , frameSize : Vec2
    , textureOffset : Vec2
    }


type alias Varying =
    { texturePos : Vec2 }


render : Texture -> Transform -> Entity
render texture { x, y, width, height } =
    WebGL.entityWith
        [ cropMask 1, DepthTest.default ]
        texturedVertexShader
        texturedFragmentShader
        box
        { offset = Vec3.fromTuple ( x, y, 3 )
        , texture = texture
        , textureSize = vec2 (toFloat (Tuple.first (Texture.size texture))) (toFloat (Tuple.second (Texture.size texture)))
        , textureOffset = vec2 0 10
        , frameSize = vec2 64 5
        , size =
            -- only expand wider walls
            vec2 width
                (if width == 1 || height == 1 then
                    height
                 else
                    height + 3
                )
        }



-- Shaders


texturedVertexShader : Shader View.Common.Vertex UniformTextured Varying
texturedVertexShader =
    [glsl|

        precision mediump float;
        attribute vec2 position;
        uniform vec3 offset;
        uniform vec2 size;
        varying vec2 texturePos;

        void main () {
          vec2 clipSpace = position * size + offset.xy - 32.0;
          gl_Position = vec4(clipSpace.x, -clipSpace.y, offset.z, 32.0);
          texturePos = position * size;
        }

    |]
