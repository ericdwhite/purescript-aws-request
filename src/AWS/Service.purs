module AWS.Service where

import Prelude

import Data.JSDate (JSDate)
import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
import Foreign.Object (Object)
import Prim.Row (class Union)
import Unsafe.Coerce (unsafeCoerce)

-- params (map) — An optional map of parameters to bind to every request sent by this service object. For more information on bound parameters, see "Working with Services" in the Getting Started Guide.
-- endpoint (String) — The endpoint URI to send requests to. The default endpoint is built from the configured region. The endpoint should be a string like 'https://{service}.{region}.amazonaws.com'.
-- accessKeyId (String) — your AWS access key ID.
-- secretAccessKey (String) — your AWS secret access key.
-- sessionToken (AWS.Credentials) — the optional AWS session token to sign requests with.
-- credentials (AWS.Credentials) — the AWS credentials to sign requests with. You can either specify this object, or specify the accessKeyId and secretAccessKey options directly.
-- credentialProvider (AWS.CredentialProviderChain) — the provider chain used to resolve credentials if no static credentials property is set.
-- region (String) — the region to send service requests to. See AWS.ACM.region for more information.
-- maxRetries (Int) — the maximum amount of retries to attempt with a request. See AWS.ACM.maxRetries for more information.
-- maxRedirects (Int) — the maximum amount of redirects to follow with a request. See AWS.ACM.maxRedirects for more information.
-- sslEnabled (Boolean) — whether to enable SSL for requests.
-- paramValidation (Boolean|map) — whether input parameters should be validated against the operation description before sending the request.
-- computeChecksums (Boolean) — whether to compute checksums for payload bodies when the service accepts it (currently supported in S3 only)
-- convertResponseTypes (Boolean) — whether types are converted when parsing response data. Currently only supported for JSON based services. Turning this off may improve performance on large response payloads. Defaults to true.
-- correctClockSkew (Boolean) — whether to apply a clock skew correction and retry requests that fail because of an skewed client clock. Defaults to false.
-- s3ForcePathStyle (Boolean) — whether to force path style URLs for S3 objects.
-- s3BucketEndpoint (Boolean) — whether the provided endpoint addresses an individual bucket (false if it addresses the root API endpoint). Note that setting this configuration option requires an endpoint to be provided explicitly to the service constructor.
-- s3DisableBodySigning (Boolean) — whether S3 body signing should be disabled when using signature version v4. Body signing can only be disabled when using https. Defaults to true.
-- retryDelayOptions (map) — A set of options to configure the retry delay on retryable errors.
-- httpOptions (map) — A set of options to pass to the low-level HTTP request.
-- apiVersion (String, Date) — a String in YYYY-MM-DD format (or a date) that represents the latest possible API version that can be used in all services (unless overridden by apiVersions). Specify 'latest' to use the latest possible version.
-- apiVersions (map<String, String|Date>) — a map of service identifiers (the lowercase service class name) with the API version to use when instantiating a service. Specify 'latest' for each individual that can use the latest available version.
-- logger (#write, #log) — an object that responds to .write() (like a stream) or .log() (like the console object) in order to log information about requests
-- systemClockOffset (Number) — an offset value in milliseconds to apply to all signing times. Use this to compensate for clock skew when your system may be out of sync with the service time. Note that this configuration option can only be applied to the global AWS.config object and cannot be overridden in service-specific configuration. Defaults to 0 milliseconds.
-- signatureVersion (String) — the signature version to sign requests with (overriding the API configuration). Possible values are: 'v2', 'v3', 'v4'.
-- signatureCache (Boolean) — whether the signature to sign requests with (overriding the API configuration) is cached. Only applies to the signature version 'v4'. Defaults to true.
-- dynamoDbCrc32 (Boolean) — whether to validate the CRC32 checksum of HTTP response bodies returned by DynamoDB. Default: true.
type OptionsType =
    ( params :: Object String
    , endpoint :: String
    , accessKeyId :: String
    , secretAccessKey :: String
    , region :: String
    , maxRetries :: Int
    , maxRedirects :: Int
    , sslEnabled :: Boolean
    , paramValidation :: ParamValidation
    , computeChecksums :: Boolean
    , convertResponseTypes :: Boolean
    , correctClockSkew :: Boolean
    , s3ForcePathStyle :: Boolean
    , s3BucketEndpoint :: Boolean
    , s3DisableBodySigning :: Boolean
    , retryDelayOptions :: RetryDelayOptions
    , httpOptions :: HttpOptions
    , apiVersion :: ApiVersion
    , apiVersions :: Object ApiVersion
    , systemClockOffset :: Int
    , signatureVersion :: String
    , signatureCache :: Boolean
    , dynamoDbCrc32 :: Boolean
    )

foreign import data Options :: Type

options :: forall o _o. Union o _o OptionsType => { |o } -> Options
options = unsafeCoerce

-- Whether input parameters should be validated against the operation description before sending the request.
--   - min [Boolean] — Validates that a value meets the min constraint. This is enabled by default when paramValidation is set to true.
--   - max [Boolean] — Validates that a value meets the max constraint.
--   - pattern [Boolean] — Validates that a string value matches a regular expression.
--   - enum [Boolean] — Validates that a string value matches one of the allowable enum values.
type ParamValidationType =
    ( min :: Boolean
    , max :: Boolean
    , pattern :: Boolean
    , enum :: Boolean
    )

foreign import data ParamValidation :: Type

class IsParamValidation a

instance isParamValidationBoolean :: IsParamValidation Boolean
instance isParamValidationRecord :: Union o _o ParamValidationType => IsParamValidation { |o }

paramValidation :: forall a. IsParamValidation a => a -> ParamValidation
paramValidation = unsafeCoerce

-- A set of options to configure the retry delay on retryable errors.
--   - base [Integer] — The base number of milliseconds to use in the exponential backoff for operation retries. Defaults to 100 ms for all services except DynamoDB, where it defaults to 50ms.
--   - customBackoff [function] — A custom function that accepts a retry count and returns the amount of time to delay in milliseconds. The base option will be ignored if this option is supplied.
type RetryDelayOptionsType =
    ( base :: Int
    , customBackoff :: Int -> Number
    )

foreign import data RetryDelayOptions :: Type

retryDelayOptions :: forall o _o. Union o _o RetryDelayOptionsType => { |o } -> RetryDelayOptions
retryDelayOptions = unsafeCoerce

-- A set of options to pass to the low-level HTTP request.
--   - proxy [String] — the URL to proxy requests through
--   - agent [http.Agent, https.Agent] — the Agent object to perform HTTP requests with. Used for connection pooling. Defaults to the global agent (http.globalAgent) for non-SSL connections. Note that for SSL connections, a special Agent object is used in order to enable peer certificate verification. This feature is only available in the Node.js environment.
--   - connectTimeout [Int] — Sets the socket to timeout after failing to establish a connection with the server after connectTimeout milliseconds. This timeout has no effect once a socket connection has been established.
--   - timeout [Int] — Sets the socket to timeout after timeout milliseconds of inactivity on the socket. Defaults to two minutes (120000).
--   - xhrAsync [Boolean] — Whether the SDK will send asynchronous HTTP requests. Used in the browser environment only. Set to false to send requests synchronously. Defaults to true (async on).
--   - xhrWithCredentials [Boolean] — Sets the "withCredentials" property of an XMLHttpRequest object. Used in the browser environment only. Defaults to false.
type HttpOptionsType =
    ( proxy :: String
    , connectTimeout :: Int
    , timeout :: Int
    , xhrAsync :: Boolean
    , xhrWithCredentials :: Boolean
    )

foreign import data HttpOptions :: Type

httpOptions :: forall o _o. Union o _o HttpOptionsType => { |o } -> HttpOptions
httpOptions = unsafeCoerce

foreign import data ApiVersion :: Type

class IsApiVersion a

instance isApiVersionString :: IsApiVersion String
instance isApiVersionJSDate :: IsApiVersion JSDate

apiVersion :: forall a. IsApiVersion a => a -> ApiVersion
apiVersion = unsafeCoerce

newtype Service = Service Foreign
newtype ServiceName = ServiceName String

foreign import serviceImpl :: String -> Foreign -> Effect Foreign

service :: forall o _o. Union o _o OptionsType => ServiceName -> { |o } -> Effect Service
service serviceName o = service' serviceName (options o)

service' :: ServiceName -> Options -> Effect Service
service' (ServiceName name) opts = do
    f <- serviceImpl name (unsafeToForeign opts)
    pure $ Service f
